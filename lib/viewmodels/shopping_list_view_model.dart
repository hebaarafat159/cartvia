import 'package:cartvia_project/data/repositories/shopping_list_repository.dart';
import 'package:cartvia_project/models/shopping_list_model.dart';
import 'package:flutter/foundation.dart';

class ShoppingListViewModel extends ChangeNotifier {
  ShoppingListViewModel({required ShoppingListRepository repository})
      : _repository = repository;

  final ShoppingListRepository _repository;

  List<ShoppingListModel> _shoppingList = const [];
  bool _isLoading = false;
  String? _errorMessage;
  String? _selectedListId;

  List<ShoppingListModel> get shoppingList => _shoppingList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasShoppingList => _shoppingList.isNotEmpty;
  String? get selectedListId => _selectedListId;

  Future<void> loadShoppingList() async {
    _isLoading = true;
    _errorMessage = null;
    _selectedListId = null;
    notifyListeners();

    try {
      _shoppingList = await _repository.fetchShoppingList();
      // TODO remove testing data
      _shoppingList = [
        ShoppingListModel(
            id: "iuefiufew8763872",
            title: "Monthly",
            description: "Every Month"),
        ShoppingListModel(
            id: "iuefiufew8775872", title: "Birthday", description: "Birthday"),
        ShoppingListModel(
            id: "iuefswiufew8763872", title: "Home", description: "Home LIst"),
      ];
      if (hasShoppingList) _selectedListId = _shoppingList[0].id;
      //TODO End testing Data
    } catch (error) {
      _errorMessage = 'Unable to load Shopping List.\n$error';
      _shoppingList = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
