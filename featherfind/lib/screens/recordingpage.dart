import 'dart:io';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:featherfind/constants/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

Future<void> requestPermission() async {
  final status = await Permission.microphone.request();
  if (status != PermissionStatus.granted) {
    throw "Microphone access denined";
  }
}

final recorder = FlutterSoundRecorder();

class Recordingpage extends StatefulWidget {
  const Recordingpage({super.key});

  @override
  State<Recordingpage> createState() => _RecordingpageState();
}

class _RecordingpageState extends State<Recordingpage> {
  RecorderController controller = RecorderController();
  bool isRecording = false;
  Future<String> getFilePath() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/audio';
    await Directory(path).create(recursive: true);
    return '$path/audio_recording.aac';
  }

  Future<void> startRecording() async {
    requestPermission();
    //await recorder.openRecorder();
    setState(() {
      isRecording = true;
    }); 
    String path = await getFilePath();
    await controller.record(path: path);
  }

  Future<void> uploadAudio() async {
    print("audio upload starting..................");
    String path = await getFilePath();
    File audioFile = File(path);

    if (await audioFile.exists()) {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://<Server>/upload'));
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

  Future<void> stopRecording() async {
    // await recorder.stopRecorder();
    // await recorder.closeRecorder();
    await controller.stop();
    setState(() {
      isRecording = false;
    });
    await uploadAudio();
  }
  //Testing the recorded audio
  // Future<void> playRecording() async {
  //   String path = await getFilePath();

  //   final player = FlutterSoundPlayer();
  //   await player.openPlayer();
  //   await player.startPlayer(fromURI: path, codec: Codec.aacADTS);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(children: [
        const SizedBox(
          height: 80,
        ),
        //if(isRecording)
        SizedBox(
          child: AudioWaveforms(
            size: const Size(400, 250), recorderController: controller,
            //shouldCalculateScrolledPosition: true,
            backgroundColor: const Color.fromARGB(255, 231, 228, 228),
            enableGesture: false,
            waveStyle: const WaveStyle(
              showMiddleLine: false,
              durationStyle: TextStyle(color: Colors.black, fontSize: 16),
              waveCap: StrokeCap.round,
              waveColor: Color.fromRGBO(0, 0, 0, 0.5),
              waveThickness: 3,
              showDurationLabel: true,
              durationLinesColor: ThemeColor.bottonColor,
              spacing: 8.0,
              showBottom: true,
              scaleFactor: 60,
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: startRecording,
                style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColor.bottonColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20)),
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                  size: 30,
                )),
            const SizedBox(
              width: 40,
            ),
            ElevatedButton(
                onPressed: stopRecording,
                style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeColor.bottonColor,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20)),
                child: const Icon(
                  Icons.stop,
                  color: Colors.white,
                  size: 30,
                )),
            //ElevatedButton(onPressed: playRecording, child: const Icon(Icons.play_arrow))
          ],
        ),
      ]),
    ));
  }
}
