import 'package:featherfind/components/detailscard.dart';
import 'package:featherfind/components/searchbar.dart';
import 'package:featherfind/constants/url.dart';
import 'package:featherfind/models/detailsmodel.dart';
import 'package:featherfind/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';

class MapDetails extends StatelessWidget {
  final int id;
  const MapDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Map(id: id);
  }
}

class Map extends StatelessWidget {
  final int id;
  const Map({super.key, required this.id});

  Future<String> getAddressFromLatLong(
      double latitude, double longitude) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks.first;

      return place.subLocality ?? "Unknown location";
    } catch (e) {
      return "Unknown location";
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DetailsModel>(
      future: APIRequest.getDetailfromID(id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData) {
          return const Center(child: Text("No images found"));
        } else {
          DetailsModel detailsList = snapshot.data!;
          double latitude = double.parse(detailsList.latitude);
          double longitude = double.parse(detailsList.longitude);

          return Scaffold(
            body: Stack(
              children: [
                const SearchBarComp(),
                FlutterMap(
                  options: MapOptions(
                    initialCenter: LatLng(latitude, longitude),
                    initialZoom: 14,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.app',
                    ),
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(latitude, longitude),
                          child: IconButton(
                            onPressed: () {

                            },
                            icon: const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 40,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                FutureBuilder<String>(
                  future: getAddressFromLatLong(latitude, longitude),
                  builder: (context, addressSnapshot) {
                    String location = addressSnapshot.connectionState == ConnectionState.waiting
                        ? "Loading..."
                        : (addressSnapshot.data ?? "Unknown location");

                    return Detailscard(
                      image: URL + detailsList.imageURL,
                      name: detailsList.birdName,
                      time: detailsList.time.substring(11, 16),
                      location: location, 
                    );
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
