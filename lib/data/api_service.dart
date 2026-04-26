import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  ApiService({http.Client? client}) : _client = client ?? http.Client();

  static const String _baseUrl = 'https://server-app-5nz3i.ondigitalocean.app';

  final http.Client _client;

  Future<List<Map<String, dynamic>>> fetchShoppingList() async {
    final response = await _client.get(Uri.parse('$_baseUrl/courses'));

    if (response.statusCode != 200) {
      throw Exception('Failed to load Shopping List (${response.statusCode})');
    }

    final dynamic decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      throw const FormatException('Unexpected response format.');
    }

    return _extractShoppingList(decodedBody)
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  List<dynamic> _extractShoppingList(Map<String, dynamic> decodedBody) {
    final dynamic topLevelBody = decodedBody['body'];
    if (topLevelBody is List) {
      return topLevelBody;
    }

    final dynamic topLevelData = decodedBody['data'];
    if (topLevelData is List) {
      return topLevelData;
    }

    if (topLevelBody is Map<String, dynamic>) {
      final dynamic nestedShoppingList =
          topLevelBody['shoppingList'] ?? topLevelBody['data'];
      if (nestedShoppingList is List) {
        return nestedShoppingList;
      }
    }

    throw const FormatException(
        'Shopping List payload is missing a shopping list.');
  }
}
