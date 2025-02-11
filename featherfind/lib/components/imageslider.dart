import 'package:featherfind/services/network.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ImageSlider extends StatelessWidget {
  const ImageSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: APIRequest.getImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("No images found"));
        } else {
          List<String> imgUrls = snapshot.data!;
          return CarouselSlider(
            options: CarouselOptions(
              height: 300,
              autoPlay: true,
              enableInfiniteScroll: true,
            ),
            items: imgUrls.map((imageUrl) {
              return Builder(builder: (BuildContext context) {
                return GestureDetector(
                  onTap: () {
                    // Handle tap (e.g., play audio)
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.0),
                      child: Image.network(
                        imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        height: 310,
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
                );
              });
            }).toList(),
          );
        }
      },
    );
  }
}
