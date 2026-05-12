class ProductModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final int quantity;
  final String measurement;
  final bool bring;

  const ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.imageUrl,
      required this.quantity,
      required this.measurement,
      required this.bring});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
      imageUrl:
          (json['imageUrl'] ?? json['image'] ?? json['thumbnail'] ?? '')
              .toString(),
      quantity: (json['quantity'] ?? 0),
      measurement: (json['measurement'] ?? '').toString(),
      bring: (json['bring'] ?? false),
    );
  }

  ProductModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    int? quantity,
    String? measurement,
    bool? bring,
  }) {
    return ProductModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      quantity: quantity ?? this.quantity,
      measurement: measurement ?? this.measurement,
      bring: bring ?? this.bring,
    );
  }
}
