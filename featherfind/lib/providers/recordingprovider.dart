import 'dart:io';
import 'dart:convert';
import 'dart:js_interop';
import 'package:featherfind/constants/theme.dart';
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
  late Predictionmodel serverResponse;

  bool get isRecording => _isRecording;
  bool get hasResponse => _hasResponse;
  //String get serverResponse => _serverResponse;
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

  // Future<void> enterTrimMode() async {
  //   _isInTrimMode = true;
  //   await controller.pause();
  //   //trimming logic here ???

  //   notifyListeners();
  // }

  // Future<void> exitTrimMode() async {
  //   _isInTrimMode = false;
  //   notifyListeners();
  // }

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

  // Future<void> uploadAudio() async {
  //   print("audio upload starting...");
  //   String path = await getFilePath();
  //   File audioFile = File(path);

  //   var fileBytes = await audioFile.readAsBytes();
  //   var multipartFile = http.MultipartFile.fromBytes(
  //     'audio',
  //     fileBytes,
  //     filename: audioFile.path.split('/').last,
  //     contentType: MediaType('audio', 'mp3'),
  //   );

  //   var request = http.MultipartRequest(
  //       'POST',
  //       Uri.parse(
  //           'https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app/birds/predict/'));
  //   request.files.add(multipartFile);
  //   var streamedResponse = await request.send();
  //   var response = await http.Response.fromStream(streamedResponse);
  //   if (response.statusCode == 200) {
  //     print("success");
  //     print({response.body});
  //     // _hasResponse = true;
  //     // notifyListeners();
  //   } else {
  //     print("oops");
  //   }
  // }

  // Future<void> fetchData() async {
  //   print("Fetching data from the server...");
  //   var url = Uri.parse(
  //       'https://3352-2400-1a00-b030-ed91-bd45-7a9f-fc9b-d0b4.ngrok-free.app/birds/predict/');
  //   try {
  //     var response = await http.get(url);
  //     if (response.statusCode == 200) {
  //       var jsonResponse = jsonDecode(response.body);
  //       _serverResponse = jsonResponse['response'] ?? "No Response Found";
  //       print("Data fetched successfully: $_serverResponse");
  //     } else {
  //       _serverResponse =
  //           "Failed to fetch data with status code: ${response.statusCode}";
  //       print(_serverResponse);
  //     }
  //   } catch (e) {
  //     _serverResponse = "An error occurred during the GET request: $e";
  //     print(_serverResponse);
  //   }
  //   _hasResponse = true;
  //   notifyListeners();
  // }

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
        Uri.parse(
            'https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app/birds/predict/'),
      );

      request.files.add(multipartFile);

      var streamedResponse =
          await request.send().timeout(Duration(seconds: 30));

      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        print("Success: ${response.body}");
        _hasResponse = true;
        final Map<String,dynamic> data = json.decode(response.body);
        serverResponse = Predictionmodel.fromJson(data);
        notifyListeners();
        //fetchData();
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
      }
    } catch (e) {
      print("Exception occurred: $e");

      // Retry if it's a connection issue
      if (e is SocketException) {
        print("Retrying in 3 seconds...");
        await Future.delayed(Duration(seconds: 3));
        return uploadAudio();
      }
    }
  }
}
