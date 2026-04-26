import 'package:cartvia_project/data/api_service.dart';
import 'package:cartvia_project/models/shopping_list.dart';

class ShoppingListRepository {
  const ShoppingListRepository({required ApiService apiService})
      : _apiService = apiService;

  final ApiService _apiService;

  Future<List<ShoppingList>> fetchShoppingList() async {
    final shoppingListMaps = await _apiService.fetchShoppingList();
    return shoppingListMaps.map(ShoppingList.fromJson).toList();
  }
}
