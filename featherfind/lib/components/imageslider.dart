import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  ImageSlider({super.key});
  final List<String> img = [
    "assets/images/bird.png",
    'assets/images/himalayan monal.jpeg',
    'assets/images/White-throated bushchat.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: 300, autoPlay: true, enableInfiniteScroll: true),
        items: img.map((item) {
          return Builder(builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                //play audio
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal:10.0),
                //child: Card(
                  //elevation: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Container(
                      color: Colors.white,
                      child: Image.asset(item,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 310,),
                    ),
                  ),
                //),
              ),
            );
          });
        }).toList());
  }
}
