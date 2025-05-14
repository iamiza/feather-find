import 'dart:io';
import 'dart:convert';
import 'package:featherfind/constants/theme.dart';
import 'package:featherfind/constants/url.dart';
import 'package:featherfind/models/predictionmodel.dart';
import 'package:featherfind/screens/recordingpage.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:http/http.dart' as http;

class Recordingprovider extends ChangeNotifier {
  bool _isRecording = false;
  bool _hasResponse = false;
  bool _hasBird = true;
  late Predictionmodel serverResponse;

  bool get isRecording => _isRecording;
  bool get hasResponse => _hasResponse;
  bool get hasBird => _hasBird;
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
    return '$path/audio_recording.mp3';
  }

  Future<void> startRecording() async {
    await requestPermisson();
    _isRecording = true;
    notifyListeners();

    String path = await getFilePath();
    await controller.record(
      path: path,
    );
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
          return AlertDialog(
            title: const Text('Recognise the Audio'),
            content: const Text("Do you want to find out which bird this is?"),
            actions: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SimpleDialogOption(
                    onPressed: () {
                      uploadAudio();
                      Navigator.pop(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Recordingpage()));
                    },
                    child: const Text(
                      'Confirm',
                      style: TextStyle(
                          fontSize: 16, color: ThemeColor.bottonColor),
                    ),
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
                    child: const Text(
                      'Decline',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              )
            ],
          );
        });
  }

  Future<void> uploadAudio() async {
    try {
      print("Audio upload starting...");
      String path = await getFilePath();
      File audioFile = File(path);

      var fileBytes = await audioFile.readAsBytes();
      var multipartFile = http.MultipartFile.fromBytes(
        'audio',
        fileBytes,
        filename: audioFile.path.split('/').last,
        contentType: MediaType('audio', 'mp3'),
      );

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('$URL/birds/predict/'),
      );

      request.files.add(multipartFile);

      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Success: ${response.body}");
        final Map<String, dynamic> data = json.decode(response.body);
        serverResponse = Predictionmodel.fromJson(data);
        print(serverResponse.hasBird);
        if (serverResponse.hasBird == true) {
          _hasResponse = true;
          _hasBird = true;
        }
        if (serverResponse.hasBird == false) {
          _hasResponse = false;
          _hasBird = false;
        }
        notifyListeners();
        //fetchData();
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception occurred: $e");

      if (e is SocketException) {
        print("Retrying in 3 seconds...");
        await Future.delayed(Duration(seconds: 3));
        return uploadAudio();
      }
    }
  }
}
