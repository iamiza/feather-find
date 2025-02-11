import 'package:featherfind/components/searchbar.dart';
import 'package:featherfind/models/locationmodel.dart';
import 'package:featherfind/screens/mapdetails.dart';
import 'package:featherfind/services/network.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class Mappage extends StatelessWidget {
  const Mappage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Map();
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: APIRequest.getLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No images found"));
          } else {
            List<LocationModel> locationList = snapshot.data!;
            return Center(
                child: Scaffold(
              body: Stack(
                children: [
                  const SearchBarComp(),
                  FlutterMap(
                    options: const MapOptions(
                      initialCenter: LatLng(27.7103, 85.3222),
                      initialZoom: 14,
                    ),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.example.app',
                      ),
                      MarkerLayer(
                        markers: locationList.map((location) {
                          return Marker(
                            point: LatLng(
                              double.parse(location.lat),
                              double.parse(location.lon),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.location_pin,
                                color: Colors.red,
                                size: 40,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const MapDetails()));
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  const Positioned(
                    top: 32,
                    left: 8,
                    right: 8,
                    child: SearchBarComp(),
                  ),
                ],
              ),
            ));
          }
        });
  }
}
