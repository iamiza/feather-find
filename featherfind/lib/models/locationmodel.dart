class LocationModel {
  final String lat;
  final String lon;

  LocationModel({required this.lat, required this.lon});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final locationData = json['location'];
    String latitude = locationData['latitude'];
    String longitude = locationData['longitude'];

    return LocationModel(lat: latitude, lon: longitude);
  }

  static List<LocationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((location) => LocationModel.fromJson(location))
        .toList();
  }
}
