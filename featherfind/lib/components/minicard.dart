import 'package:featherfind/screens/mapdetails.dart';
import 'package:flutter/material.dart';

class Minicard extends StatelessWidget {
  const Minicard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Align(
            child: Container(
              width: 312,
              height: 88,
              padding: const EdgeInsets.fromLTRB(8, 12, 0, 0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(217, 217, 217, 0.6),
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
                      child: Image.asset(
                        "assets/images/bird.png",
                        height: 64,
                        width: 56,
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Expanded(
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            "Bird Name",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.access_time,
                                color: Colors.blue,
                                size: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Time")
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          const Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 12,
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text("Location")
                            ],
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MapDetails()));
                          },
                          icon: const Icon(Icons.arrow_forward_ios_rounded),
                          iconSize: 16,
                        ),
                      ],
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
