import 'package:cartvia_project/viewmodels/home_view_model.dart';
import 'package:cartvia_project/viewmodels/products_view_model.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:cartvia_project/views/products_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();
    final shoppingListViewModel = context.watch<ShoppingListViewModel>();
    final productsViewModel = context.watch<ProductsViewModel>();
    final shoppingLists = shoppingListViewModel.shoppingList;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(viewModel.title),
          actions: [
            IconButton(
                onPressed: () {},
                icon: CircleAvatar(
                  radius: 26,
                  backgroundColor: Colors.grey.shade300,
                  child: const Text(
                    "S",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ))
          ],
        ),
        body: Container(
          // Background gradient (very subtle like design)
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFF3EEE8),
                Color(0xFFEDE6DF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (shoppingListViewModel.isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                  else if (shoppingListViewModel.errorMessage != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          shoppingListViewModel.errorMessage!,
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: shoppingListViewModel.loadShoppingList,
                          child: const Text("Retry"),
                        ),
                      ],
                    )
                  else if (shoppingLists.isEmpty)
                    Center(
                      child: Text("No shopping lists available."),
                    )
                  else
                    const Text(
                      "Choose a shopping list",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  if (shoppingLists.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: productsViewModel.selectedListId,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: "Select a shopping list",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: shoppingLists
                          .map(
                            (shoppingList) => DropdownMenuItem<String>(
                              value: shoppingList.id,
                              child: Text(shoppingList.title),
                            ),
                          )
                          .toList(),
                      onChanged: productsViewModel.setSelectedListId,
                    ),
                    const SizedBox(height: 20),
                    const Expanded(
                      child: ProductsListView(),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ));
  }
}
