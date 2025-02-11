class DetailsModel {
  final String imageURL;
  final int birdId;
  final String birdName;

  DetailsModel(
      {required this.imageURL, required this.birdId, required this.birdName});

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> birdset = json['birdsets'] ?? [];

    String image = birdset.isNotEmpty ? (birdset[0]['image'] ?? '') : '';
    int id = json['id'] ?? 0; // Extract bird_id from JSON
    String name = json['name'];
    return DetailsModel(imageURL: image, birdId: id, birdName: name);
  }

  static List<DetailsModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((bird) => DetailsModel.fromJson(bird)).toList(); // Process each bird
  }
}
