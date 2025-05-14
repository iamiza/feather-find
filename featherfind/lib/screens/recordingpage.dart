import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:featherfind/components/prediction.dart';
import 'package:featherfind/constants/theme.dart';
import 'package:featherfind/constants/url.dart';
import 'package:featherfind/providers/recordingprovider.dart';
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
          
            SizedBox(
                child: AudioVisualization(controller: provider.controller)),
          
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
                if (provider.isRecording)
                  const SizedBox(
                    width: 80,
                  ),
                if (provider.isRecording)
                  ElevatedButton(
                      onPressed: () {
                        provider.stopRecording(context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColor.bottonColor,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(20)),
                      child: const Icon(
                        Icons.stop,
                        color: Colors.white,
                        size: 30,
                      )),
                  const SizedBox(height: 20,),
                
              ],
            ),
            const SizedBox(height: 32),
            if (provider.hasResponse)
              Prediction(birdname: provider.serverResponse.name, img: URL+ provider.serverResponse.image, confidence: double.parse(provider.serverResponse.confidence.toString().substring(0, 6)),birdId: provider.serverResponse.id,),
            if(provider.hasBird == false)
              const Text("No bird sound present")      // const Minicard(
            //               img:
            //                   "https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app" +
            //                       "/media/images/Black-necked_Crane_1_0.jpg.webp",
            //               birdname: "Black-necked Crane",time: "10:30",location: "Lalitpur",)
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
        showTop: true,
        scaleFactor: 90,
      ),
    );
  }
}
