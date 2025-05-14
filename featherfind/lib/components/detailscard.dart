import 'package:featherfind/constants/theme.dart';
import 'package:flutter/material.dart';

class Detailscard extends StatelessWidget {
  final String image, name, time, location;
  const Detailscard({super.key,required this.image,required this.name,required this.time,required this.location});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            height: 256,
            padding: const EdgeInsets.fromLTRB(16, 32, 0, 0),
            decoration: BoxDecoration(
              color: Colors.white,
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
                    height: 16,
                  ),
                  ClipRect(
                    clipBehavior: Clip.hardEdge,
                    child: Image.network(
                      image,
                      height: 180,
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        'Found 2 entries',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 22,
                      ),
                      const Text(
                        "Recently Identified",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Colors.blue,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(time)
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                       Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(location,)
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ThemeColor.bottonColor,
                              ),
                              child: const Text(
                                "View More",
                                style: TextStyle(color: Colors.white),
                              ))
                        ],
                      )
                    ],
                  )
                ]),
          ),
        )
      ],
    );
  }
}
