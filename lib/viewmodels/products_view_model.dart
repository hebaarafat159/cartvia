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

  List<String> get products => selectedShoppingList?.products ?? const [];

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
}
