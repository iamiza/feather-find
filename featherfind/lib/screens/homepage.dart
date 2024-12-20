import 'package:featherfind/components/imageslider.dart';
import 'package:featherfind/components/minicard.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromRGBO(22, 21, 26, 1),
            Color.fromRGBO(2, 131, 70, 1)
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: Column(
            children: [
              const SizedBox(height: 80,),
              ImageSlider(),
              const SizedBox(height: 24,),
              const Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 30),
                  child: Text(
                    "Recently Located",
                    style: TextStyle(color: Colors.white,),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Minicard(),
                      SizedBox(
                        height: 10,
                      ),
                      Minicard(),
                      SizedBox(
                        height: 10,
                      ),
                      Minicard(),
                      SizedBox(
                        height: 10,
                      ),
                      Minicard(),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
