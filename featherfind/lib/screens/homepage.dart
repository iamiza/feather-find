import 'package:featherfind/components/imageslider.dart';
import 'package:featherfind/components/minicard.dart';
import 'package:featherfind/models/detailsmodel.dart';
import 'package:featherfind/services/network.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  Future<List<String>> birdList = APIRequest.getImage();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DetailsModel>>(
        future: APIRequest.getDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No images found"));
          } else {
            List<DetailsModel> detailsList = snapshot.data!;
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
                      const SizedBox(
                        height: 80,
                      ),
                      const ImageSlider(),
                      const SizedBox(
                        height: 24,
                      ),
                      const Align(
                        alignment: Alignment.topRight,
                        child: Padding(
                          padding: EdgeInsets.only(right: 30),
                          child: Text(
                            "Recently Located",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      
                      Expanded(
                            child: ListView.builder(
                                itemCount: 6,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [Minicard(
                                        img: "https://ab6e-2400-1a00-b030-529c-6650-9e4-9713-fb08.ngrok-free.app"+detailsList[index].imageURL,
                                        birdname: detailsList[index].birdName),
                                        const SizedBox(height: 8,)
                    ]);
                                })
                            ),
                      
                    ],
                  )),
            );
          }
        });
  }
}
