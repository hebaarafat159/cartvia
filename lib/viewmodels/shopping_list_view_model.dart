import 'package:cartvia_project/data/repositories/shopping_list_repository.dart';
import 'package:cartvia_project/models/product_model.dart';
import 'package:cartvia_project/models/shopping_list_model.dart';
import 'package:flutter/foundation.dart';

class ShoppingListViewModel extends ChangeNotifier {
  ShoppingListViewModel({required ShoppingListRepository repository})
      : _repository = repository;

  final ShoppingListRepository _repository;

  List<ShoppingListModel> _shoppingList = const [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ShoppingListModel> get shoppingList => _shoppingList;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasShoppingList => _shoppingList.isNotEmpty;

  Future<void> loadShoppingList() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _shoppingList = await _repository.fetchShoppingList();
      // TODO remove testing data
      _shoppingList = [
        ShoppingListModel(
          id: "iuefiufew8763872",
          title: "Monthly",
          description: "Every Month",
          products: const [
            ProductModel(
              id: "product-1",
              title: "Milk",
              description: "Full cream milk",
              quantity: 2,
              measurement: "liters",
              bring: false,
            ),
            ProductModel(
              id: "product-2",
              title: "Eggs",
              description: "Fresh eggs",
              quantity: 12,
              measurement: "pcs",
              bring: true,
            ),
            ProductModel(
              id: "product-3",
              title: "Bread",
              description: "Whole wheat loaf",
              quantity: 1,
              measurement: "loaf",
              bring: false,
            ),
            ProductModel(
              id: "product-4",
              title: "Coffee",
              description: "Ground coffee",
              quantity: 1,
              measurement: "bag",
              bring: false,
            ),
            ProductModel(
              id: "product-5",
              title: "Apples",
              description: "Red apples",
              quantity: 6,
              measurement: "pcs",
              bring: true,
            ),
          ],
        ),
        ShoppingListModel(
          id: "iuefiufew8775872",
          title: "Birthday",
          description: "Birthday",
          products: const [
            ProductModel(
              id: "product-6",
              title: "Cake",
              description: "Birthday cake",
              quantity: 1,
              measurement: "pc",
              bring: true,
            ),
            ProductModel(
              id: "product-7",
              title: "Candles",
              description: "Party candles",
              quantity: 1,
              measurement: "pack",
              bring: false,
            ),
            ProductModel(
              id: "product-8",
              title: "Juice",
              description: "Mixed fruit juice",
              quantity: 3,
              measurement: "bottles",
              bring: false,
            ),
            ProductModel(
              id: "product-9",
              title: "Chips",
              description: "Salted chips",
              quantity: 4,
              measurement: "bags",
              bring: true,
            ),
          ],
        ),
        ShoppingListModel(
            id: "iuefswiufew8763872",
            title: "Home",
            description: "Home LIst",
            products: []
            // const [
            //   ProductModel(
            //     id: "product-10",
            //     title: "Detergent",
            //     description: "Laundry detergent",
            //     quantity: 1,
            //     measurement: "bottle",
            //     bring: false,
            //   ),
            //   ProductModel(
            //     id: "product-11",
            //     title: "Paper Towels",
            //     description: "Kitchen roll",
            //     quantity: 2,
            //     measurement: "packs",
            //     bring: true,
            //   ),
            //   ProductModel(
            //     id: "product-12",
            //     title: "Soap",
            //     description: "Hand soap",
            //     quantity: 3,
            //     measurement: "bars",
            //     bring: false,
            //   ),
            // ],
            ),
      ];
      //TODO End testing Data
    } catch (error) {
      _errorMessage = error.toString();
      _shoppingList = const [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
