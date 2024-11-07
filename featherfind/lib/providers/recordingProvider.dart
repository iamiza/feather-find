import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:http/http.dart' as http;

class Recordingprovider extends ChangeNotifier {
  bool _isRecording = false;

  bool get isRecording => _isRecording;
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

  Future<void> startRecording() async {
    await requestPermisson();
    _isRecording = true;
    notifyListeners();

    String path = await getFilePath();
    await controller.record(path: path);
  }

  Future<void> stopRecording() async {
    await controller.stop();
    _isRecording = false;
    notifyListeners();
    await uploadAudio();
  }

  Future<void> pauseRecording() async {
    await controller.pause();
    _isRecording = false;
    notifyListeners();
  }

  Future<void> uploadAudio() async {
    print("audio upload starting..................");
    String path = await getFilePath();
    File audioFile = File(path);

    if (await audioFile.exists()) {
      var request =
          http.MultipartRequest('POST', Uri.parse('https://8ac0-2400-1a00-b060-e64b-d7b4-8d69-4803-2130.ngrok-free.app/upload'));
      request.files.add(await http.MultipartFile.fromPath(
          'audio', audioFile.path,
          contentType: MediaType('audio', 'aac')));
      var response = await request.send();
      if (response.statusCode == 200) {
        print("success");
      } else {
        print("oops");
      }
    }
  }
 
}
