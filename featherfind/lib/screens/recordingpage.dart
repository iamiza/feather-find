import 'dart:io';
import 'package:featherfind/constants/theme.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

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
  Future<String> getFilePath() async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/audio';
    await Directory(path).create(recursive: true);
    return '$path/audio_recording.aac';
  }

  Future<void> startRecording() async {
    requestPermission();
    await recorder.openRecorder();
    String path = await getFilePath();
    await recorder.startRecorder(toFile: path);
  }

  Future<void> stopRecording() async {
    await recorder.stopRecorder();
    await recorder.closeRecorder();
  }
  
  Future<void> playRecording() async {
    String path = await getFilePath();

    final player = FlutterSoundPlayer();
    await player.openPlayer();
    await player.startPlayer(
        fromURI: path, codec: Codec.aacADTS);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: startRecording, 
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.bottonColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20)
              ),
              
              child: const Icon(Icons.mic, color: Colors.white, size: 30,)),
          const SizedBox(
            width: 40,
          ),
          ElevatedButton(
              onPressed: stopRecording, 
              style: ElevatedButton.styleFrom(
                backgroundColor: ThemeColor.bottonColor,
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20)
              ),
              child: const Icon(Icons.stop, color: Colors.white,size: 30,)),
        ],
      ),
    ));
  }
}
