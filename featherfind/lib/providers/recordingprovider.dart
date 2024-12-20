import 'dart:io';
import 'package:featherfind/constants/theme.dart';
import 'package:featherfind/screens/recordingpage.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:http/http.dart' as http;

class Recordingprovider extends ChangeNotifier {
  bool _isRecording = false;
  bool _isInTrimMode = false;

  bool get isRecording => _isRecording;
  bool get isInTrimMode => _isInTrimMode;

  RecorderController controller = RecorderController();

  Future<void> requestPermisson() async {
    final status = await Permission.microphone.request();
    if (status.isDenied) {
      throw "Access Denied";
    }
  }

  Future<String> getFilePath() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/audio';
    await Directory(path).create(recursive: true);
    return '$path/audio_recording.aac';
  }

  Future<void> enterTrimMode() async {
    _isInTrimMode = true;
    await controller.pause();
    //trimming logic here ???

    notifyListeners();
  }

  Future<void> exitTrimMode() async {
    _isInTrimMode = false;
    notifyListeners();
  }

  Future<void> startRecording() async {
    await requestPermisson();
    _isRecording = true;
    notifyListeners();

    String path = await getFilePath();
    await controller.record(path: path);
  }

  Future<void> stopRecording(BuildContext context) async {
    await controller.stop();
    _isRecording = true;
    notifyListeners();
    _askToUpload(context);
  }

  Future<void> pauseRecording() async {
    await controller.pause();
    _isRecording = false;
    notifyListeners();
  }

  Future<void> _askToUpload(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Recognise the Audio'),
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      //uploadAudio();
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recordingpage()));
                    },
                    child: const Text('Confirm',style: TextStyle(fontSize: 16,color: ThemeColor.bottonColor),),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recordingpage()));
                    },
                    child: const Text('Decline',style: TextStyle(fontSize: 16),),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future<void> uploadAudio() async {
    print("audio upload starting..................");
    String path = await getFilePath();
    File audioFile = File(path);

    var fileBytes = await audioFile.readAsBytes();
    var multipartFile = http.MultipartFile.fromBytes(
      'audio',
      fileBytes,
      filename: audioFile.path.split('/').last,
      contentType: MediaType('audio', 'aac'),
    );

    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://bb47-2400-1a00-b060-e64b-53a-39c9-887e-af0b.ngrok-free.app/upload'));
    request.files.add(multipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      print("success");
    } else {
      print("oops");
    }
  }
}
