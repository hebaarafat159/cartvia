class ShoppingList {
  final String id;
  final String title;
  final String description;

  ShoppingList({
    required this.id,
    required this.title,
    required this.description,
  });

  factory ShoppingList.fromJson(Map<String, dynamic> json) {
    return ShoppingList(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      title: (json['title'] ?? 'Untitled course').toString(),
      description: (json['description'] ?? '').toString(),
    );
  }
}
