import 'package:featherfind/constants/url.dart';
import 'package:featherfind/models/detailsmodel.dart';
import 'package:featherfind/models/imagemodel.dart';
import 'package:featherfind/models/locationmodel.dart';
import 'package:http/http.dart';
//import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/material.dart';

class APIRequest {
  //static const serverIP = "https://27c7-27-34-65-97.ngrok-free.app";

  static Future<List<String>> getImage() async {
    try {
      var url = Uri.parse(
          "$URL/birds");

      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<ImageModel> imageList = ImageModel.fromJsonList(data);
        List<String> imagePath =
            imageList.map<String>((item) => item.imageURL).take(5).toList();
        //print(imagePath);
        List<String> imageUrls = imagePath
            .map((item) =>
                "$URL/$item")
            .toList();
        return imageUrls;
      } else {
        throw Exception("Failed to get images");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  static Future<List<DetailsModel>> getDetails() async {
    var url = Uri.parse(
        "$URL/locations/bird/");

    try {
      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<DetailsModel> detailsList = DetailsModel.fromJsonList(data);
        //print(detailsList);
        return detailsList;
      } else {
        throw Exception("Failed to get details");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }

  static Future<List<LocationModel>> getLocation() async {
    var url = Uri.parse(
        "$URL/locations/bird/");
    try {
      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<LocationModel> locationList = LocationModel.fromJsonList(data);
        return locationList;
      } else {
        throw Exception("Failed to get locations");
      }
    } catch (e) {
      throw Exception("Error $e");
    }
  }
static Future<DetailsModel> getDetailfromID(int id) async {
  final Uri url = Uri.parse("$URL/locations/bird/$id");

  try {
    final http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      final dynamic decodedData = json.decode(response.body);

      if (decodedData is List) {
        if (decodedData.isNotEmpty && decodedData.first is Map<String, dynamic>) {
          // Extract the first item from the list and pass it to the model
          return DetailsModel.fromJson(decodedData.first);
        } else {
          throw Exception("Unexpected list format from API: Empty or Invalid Items");
        }
      } else {
        throw Exception("Unexpected data format from API: Expected List, got ${decodedData.runtimeType}");
      }
    } else {
      throw Exception("Failed to get details: HTTP ${response.statusCode}");
    }
  } catch (e) {
    throw Exception("Error fetching details: $e");
  }
}

}
