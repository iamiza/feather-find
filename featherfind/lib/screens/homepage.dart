import 'package:featherfind/components/imageslider.dart';
import 'package:featherfind/components/minicard.dart';
import 'package:featherfind/models/detailsmodel.dart';
import 'package:featherfind/services/network.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Homepage extends StatelessWidget {
  Homepage({super.key});
  Future<List<String>> birdList = APIRequest.getImage();
  

Future<String> getAddressFromLatLong(double latitude, double longitude) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks.first;
    
    return "${place.locality},${place.country}";
  } catch (e) {
    return "Unknown location";
  }
}
List<String> locations = [
    "Kathmandu",
    "Pokhara",
    "Lalitpur",
    "Bhaktapur",
    "Chitwan","Lumbini",
    "Nagarkot",
    "Rara Lake",
    "Everest Base Camp",
    "Annapurna Circuit",
    "Bandipur",
    "Ilam",];

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
  children: [
    FutureBuilder<String>(
      future: getAddressFromLatLong(
        double.parse(detailsList[index].latitude),
        double.parse(detailsList[index].longitude),
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Minicard(
            img: "https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app" + detailsList[index].imageURL,
            birdname: detailsList[index].birdName,
            time: detailsList[index].time.substring(11, 16),
            location: "Fetching location...", // Placeholder text while loading
          );
        } else if (snapshot.hasError) {
          return Minicard(
            img: "https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app" + detailsList[index].imageURL,
            birdname: detailsList[index].birdName,
            time: detailsList[index].time.substring(11, 16),
            location: "Unknown", // Error handling
          );
        } else {
          return Minicard(
            img: "https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app" + detailsList[index].imageURL,
            birdname: detailsList[index].birdName,
            time: detailsList[index].time.substring(11, 16),
            location: snapshot.data ?? "Unknown", // Display the resolved location
          );
        }
      },
    ),
    const SizedBox(height: 8),
  ],
);

                                })
                            ),
                      
                    ],
                  )),
            );
          }
        });
  }
}
