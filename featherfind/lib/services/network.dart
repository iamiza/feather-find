import 'package:featherfind/models/detailsmodel.dart';
import 'package:featherfind/models/imagemodel.dart';
import 'package:featherfind/models/locationmodel.dart';
import 'package:http/http.dart';
//import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:flutter/material.dart';

class APIRequest {
  static const serverIP = "https://4943-2400-1a00-b030-ed91-b2f9-7e87-6784-79e3.ngrok-free.app";

  static Future<List<String>> getImage() async {
    try {
      var url = Uri.parse(
          "$serverIP/birds");

      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<ImageModel> imageList = ImageModel.fromJsonList(data);
        List<String> imagePath =
            imageList.map<String>((item) => item.imageURL).take(5).toList();
        print(imagePath);
        List<String> imageUrls = imagePath
            .map((item) =>
                "$serverIP/$item")
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
        "$serverIP/locations/bird/");

    try {
      final Response response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<DetailsModel> detailsList = DetailsModel.fromJsonList(data);
        print(detailsList);
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
        "$serverIP/locations/bird/");
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
}
