import 'package:featherfind/constants/url.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class LocationService {
  Future<Position?> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return null;
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> sendLocation(int birdId) async {
    // Position? position = await _determinePosition();
    // if (position == null) {
    //   print("Could not determine location.");
    //   return;
    // }

    String timestamp = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    String url = "$URL/locations/birds/$birdId/";

    Map<String, dynamic> data = {
      "latitude": 27,
      "longitude": 85,
      "timestamp": timestamp,
    };

    try {
      var response = await http.post(
        Uri.parse(url),
              headers: {"Content-Type": "application/json"}, // Set JSON headers
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        print("Location sent successfully.");
      } else {
        print("Failed to send location: ${response.body}");
      }
    } catch (e) {
      print("Error sending location: $e");
    }
  }
}
