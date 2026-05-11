class ShoppingListModel {
  final String id;
  final String title;
  final String description;
  final List<String> products;

  ShoppingListModel({
    required this.id,
    required this.title,
    required this.description,
    this.products = const [],
  });

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) {
    final dynamic productsJson = json['products'] ?? json['items'];

    return ShoppingListModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
      products: productsJson is List
          ? productsJson.map((product) => product.toString()).toList()
          : const [],
    );
  }
}
