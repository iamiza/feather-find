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
          child: const Column(
            children: [
              SizedBox(height: 300,),
              SingleChildScrollView(
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
                    
                    
                  ],
                ),
              )
            ],
          )),
    );
  }
}
