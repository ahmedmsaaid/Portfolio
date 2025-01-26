class FileModel {
  final String name;
  final String url;

  FileModel({required this.name, required this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      name: json['name'],
      url: json['download_url'],
    );
  }
}

class FileImagesModel {
  final List<String> images;

  FileImagesModel({required this.images});

  factory FileImagesModel.fromJson(List<dynamic> json) {
    return FileImagesModel(
      images: json.map((image) => image['download_url'] as String).toList(),
    );
  }
}
