class ProductModel {
  final String id;
  final String title;
  final String description;
  final List<String> images;
  final int quantity;
  final String measurement;
  final bool bring;

  const ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      this.images = const [],
      required this.quantity,
      required this.measurement,
      required this.bring});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
      images: _parseImages(json),
      quantity: (json['quantity'] ?? 0),
      measurement: (json['measurement'] ?? '').toString(),
      bring: (json['bring'] ?? false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'images': images,
      'imageUrl': primaryImage,
      'quantity': quantity,
      'measurement': measurement,
      'bring': bring,
    };
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? images,
    int? quantity,
    String? measurement,
    bool? bring,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      quantity: quantity ?? this.quantity,
      measurement: measurement ?? this.measurement,
      bring: bring ?? this.bring,
    );
  }

  String get primaryImage => images.isEmpty ? '' : images.first;

  static List<String> _parseImages(Map<String, dynamic> json) {
    final dynamic imagesJson = json['images'];

    if (imagesJson is List) {
      return imagesJson
          .map(_parseImageValue)
          .where((image) => image.isNotEmpty)
          .toList();
    }

    final fallbackImages = [
      json['imageUrl'],
      json['image'],
      json['thumbnail'],
    ].map(_parseImageValue).where((image) => image.isNotEmpty).toList();

    return fallbackImages;
  }

  static String _parseImageValue(dynamic value) {
    if (value is String) {
      return value;
    }

    if (value is Map<String, dynamic>) {
      return (value['url'] ?? value['path'] ?? value['src'] ?? '').toString();
    }

    return '';
  }
}
