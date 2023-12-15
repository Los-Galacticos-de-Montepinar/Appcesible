class GalleryModel {
  final int id;
  final int type;
  final String description;

  GalleryModel({
    required this.id,
    required this.type,
    required this.description
  }) ;

  // Factory method that creates a Gallery instance from a JSON
  factory GalleryModel.fromJSON(Map<String, dynamic> json) {
    return GalleryModel(
      id: json['id'] as int,
      type: json['imageType'] as int,
      description: json['imageDesc'] as String,
    );
  }

  // toString
  @override
  String toString() {
    return 'id: $id, userName: $type, pfp: $description';
  }
}