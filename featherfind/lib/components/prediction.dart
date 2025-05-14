import 'package:featherfind/constants/theme.dart';
import 'package:featherfind/screens/mapbird.dart';
import 'package:flutter/material.dart';

class Prediction extends StatelessWidget {
  final String birdname, img;
  final double confidence;
  final int birdId;
  const Prediction(
      {super.key,
      required this.birdname,
      required this.img,
      required this.confidence,
      required this.birdId});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          child: Container(
            width: 312,
            height: 88,
            padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(70, 217, 217, 217),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 8,
                  ),
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: SizedBox(
                      width: 68,
                      height: 68,
                      child: Image.network(
                        img,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                              child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                              child: Icon(Icons.broken_image, size: 50));
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          birdname,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 4,
                            ),
                            Text("Confidence : $confidence")
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("Map the Bird"),
                                content:
                                    const Text("Do you want to map this bird?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      LocationService().sendLocation(birdId);
                                    },
                                    child: const Text(
                                      "Accept",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ThemeColor.bottonColor),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      "Decline",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.grey),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        icon: const Icon(Icons.arrow_forward_ios_rounded),
                        iconSize: 16,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ]),
          ),
        )
      ],
    );
  }
}
