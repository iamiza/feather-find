// class DetailsModel {
//   final String imageURL;
//   final int birdId;
//   final String birdName;

//   DetailsModel(
//       {required this.imageURL, required this.birdId, required this.birdName});

//   factory DetailsModel.fromJson(Map<String, dynamic> json) {
//     List<dynamic> birdset = json['birdsets'] ?? [];

//     String image = birdset.isNotEmpty ? (birdset[0]['image'] ?? '') : '';
//     int id = json['id'] ?? 0; // Extract bird_id from JSON
//     String name = json['name'];
//     return DetailsModel(imageURL: image, birdId: id, birdName: name);
//   }

//   static List<DetailsModel> fromJsonList(List<dynamic> jsonList) {
//     return jsonList.map((bird) => DetailsModel.fromJson(bird)).toList(); // Process each bird
//   }
// }
class DetailsModel {
  final String imageURL;
  final int birdId;
  final String birdName;
  final String species;
  final String background;
  final String populationTrend;
  final String birdUrl;
  final String latitude;
  final String longitude;
  final String time;
  final String locationName;
  final String placeType;

  DetailsModel({
    required this.imageURL,
    required this.birdId,
    required this.birdName,
    required this.species,
    required this.background,
    required this.populationTrend,
    required this.birdUrl,
    required this.latitude,
    required this.longitude,
    required this.time,
    required this.locationName,
    required this.placeType,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic>? location = json['location'];
    Map<String, dynamic>? bird = json['bird'];
    List<dynamic> birdsets = bird?['birdsets'] ?? [];

    return DetailsModel(
      imageURL: birdsets.isNotEmpty ? (birdsets[0]['image'] ?? '') : '',
      birdId: bird?['id'],
      birdName: bird?['name'] ?? '',
      species: bird?['species'] ?? '',
      background: bird?['background'] ?? '',
      populationTrend: bird?['population_trend'] ?? '',
      birdUrl: bird?['url'] ?? '',
      latitude: location?['latitude'] ?? '',
      longitude: location?['longitude'] ?? '',
      time: json['spotted_time'] ?? '',
      locationName: location?['name'] ?? '',
      placeType: location?['place_type'] ?? '',
    );
  }

  get image => null;

  static List<DetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((bird) => DetailsModel.fromJson(bird)).toList();
  }
}
