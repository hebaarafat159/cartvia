class ShoppingListModel {
  final String id;
  final String title;
  final String description;

  ShoppingListModel({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ShoppingListModel.fromJson(Map<String, dynamic> json) {
    return ShoppingListModel(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }
}
