import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:featherfind/constants/theme.dart';
import 'package:featherfind/providers/recordingProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

RecorderController controller = RecorderController();

class Recordingpage extends StatelessWidget {
  const Recordingpage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<Recordingprovider>(
      builder: (context, provider, child) {
        return Center(
          child: Column(children: [
            const SizedBox(
              height: 80,
            ),
            //if (recordingState.isRecording)
            SizedBox(child: AudioVisualization(controller: provider.controller)),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: provider.isRecording
                        ? provider.pauseRecording
                        : provider.startRecording,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColor.bottonColor,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20)),
                    child: Icon(
                      provider.isRecording ? Icons.pause : Icons.mic,
                      color: Colors.white,
                      size: 30,
                    )),
                //if (recordingState.isRecording)
                const SizedBox(
                  width: 80,
                ),
                //if(recordingState.isRecording)
                ElevatedButton(
                    onPressed: provider.stopRecording,
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
        );
      },
    ));
  }
}

class AudioVisualization extends StatelessWidget {
  const AudioVisualization({
    super.key,
    required this.controller,
  });

  final RecorderController controller;

  @override
  Widget build(BuildContext context) {
    return AudioWaveforms(
      size: const Size(400, 250), recorderController: controller,
      //shouldCalculateScrolledPosition: true,
      backgroundColor: const Color.fromARGB(255, 231, 228, 228),
      enableGesture: true,
      waveStyle: const WaveStyle(
        showMiddleLine: false,
        //middleLineColor: Colors.black,
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
    );
  }
}
