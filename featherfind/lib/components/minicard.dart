import 'package:featherfind/screens/mapdetails.dart';
import 'package:flutter/material.dart';

class Minicard extends StatelessWidget {
  final String birdname, img, time, location;
  final int id;
  const Minicard(
      {super.key,
      required this.img,
      required this.birdname,
      required this.time,
      required this.location,
      required this.id});
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
                            const Icon(
                              Icons.access_time,
                              color: Colors.blue,
                              size: 12,
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
                              size: 12,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(location)
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
                                  builder: (context) => MapDetails(
                                        id: id,
                                      )));
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
