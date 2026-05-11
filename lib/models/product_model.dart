class Product {
  final String id;
  final String title;
  final String description;
  final int quantity;
  final String measurement;
  final bool bring;

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.quantity,
      required this.measurement,
      required this.bring});

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
      quantity: (json['quantity'] ?? 0),
      measurement: (json['measurement'] ?? '').toString(),
      bring: (json['bring'] ?? false),
    );
  }
}
