import 'package:cartvia_project/models/product_model.dart';
import 'package:cartvia_project/models/shopping_list_model.dart';
import 'package:flutter/foundation.dart';

class ProductsViewModel extends ChangeNotifier {
  List<ShoppingListModel> _shoppingLists = const [];
  String? _selectedListId;

  String? get selectedListId => _selectedListId;

  ShoppingListModel? get selectedShoppingList {
    if (_selectedListId == null) return null;

    for (final shoppingList in _shoppingLists) {
      if (shoppingList.id == _selectedListId) {
        return shoppingList;
      }
    }

    return null;
  }

  List<ProductModel> get products => selectedShoppingList?.products ?? const [];

  void updateShoppingLists(List<ShoppingListModel> shoppingLists) {
    final previousSelectedListId = _selectedListId;
    final previousShoppingLists = _shoppingLists;
    var shouldNotify = false;

    if (!listEquals(previousShoppingLists, shoppingLists)) {
      _shoppingLists = shoppingLists;
      shouldNotify = true;
    }

    if (_shoppingLists.isEmpty) {
      _selectedListId = null;
      if (previousSelectedListId != _selectedListId || shouldNotify) {
        notifyListeners();
      }
      return;
    }

    final hasSelectedList = _shoppingLists.any(
      (shoppingList) => shoppingList.id == _selectedListId,
    );

    if (!hasSelectedList) {
      _selectedListId = _shoppingLists.first.id;
      shouldNotify = true;
    }

    if (shouldNotify) {
      notifyListeners();
    }
  }

  void setSelectedListId(String? listId) {
    if (_selectedListId == listId) return;
    _selectedListId = listId;
    notifyListeners();
  }

  void setProductBring({
    required String productId,
    required bool bring,
  }) {
    final selectedShoppingList = this.selectedShoppingList;
    if (selectedShoppingList == null) return;

    final shoppingListIndex = _shoppingLists.indexWhere(
      (shoppingList) => shoppingList.id == selectedShoppingList.id,
    );
    if (shoppingListIndex == -1) return;

    final updatedProducts = selectedShoppingList.products.map((product) {
      if (product.id != productId) return product;
      return product.copyWith(bring: bring);
    }).toList();

    _shoppingLists = List<ShoppingListModel>.from(_shoppingLists);
    _shoppingLists[shoppingListIndex] = ShoppingListModel(
      id: selectedShoppingList.id,
      title: selectedShoppingList.title,
      description: selectedShoppingList.description,
      products: updatedProducts,
    );

    notifyListeners();
  }
}
