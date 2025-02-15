class Predictionmodel {
  final String name;
  final String image;
  final String id;
  final String confidence;
  final bool hasBird;

  Predictionmodel({
    required this.image,
    required this.confidence,
    required this.id,
    required this.name,
    required this.hasBird,
  });

  factory Predictionmodel.fromJson(Map<String, dynamic> json) {
    String predictedName = json['predicted_class'];
    String predictedId = json['bird_id'];
    String predictedImage = json['image'];
    String predictedConfidence = json['confidence'];
    bool predictedHasBird = json['has_bird'];
    return Predictionmodel(
        image: predictedImage,
        confidence: predictedConfidence,
        id: predictedId,
        name: predictedName,
        hasBird: predictedHasBird);
  }
}
