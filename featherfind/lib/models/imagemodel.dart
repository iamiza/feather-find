class ImageModel {
  final String imageURL;

  ImageModel({required this.imageURL, });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> birdset = json['birdsets'] ?? [];

    String image = birdset.isNotEmpty ? (birdset[0]['image'] ?? '') : '';
    
    return ImageModel(imageURL: image, );
  }

  static List<ImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .expand((bird) => (bird["birdsets"] as List<dynamic>? ?? [])
            .map((birdset) => ImageModel(
                  imageURL: birdset["image"] ?? "",
                  
                )))
        .where((imageModel) => imageModel.imageURL.isNotEmpty)
        .toList();
  }
}
