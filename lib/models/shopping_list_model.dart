import 'package:cartvia_project/models/product_model.dart';

class ShoppingListModel {
  final String id;
  final String title;
  final String description;
  final List<ProductModel> products;

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
          ? productsJson
              .map(
                (product) => switch (product) {
                  Map<String, dynamic> value => ProductModel.fromJson(value),
                  _ => ProductModel(
                      id: '',
                      title: product.toString(),
                      description: '',
                      images: const [],
                      quantity: 0,
                      measurement: '',
                      bring: false,
                    ),
                },
              )
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}
