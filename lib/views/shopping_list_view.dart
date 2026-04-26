import 'package:cartvia_project/models/shopping_list.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingListView extends StatelessWidget {
  const ShoppingListView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ShoppingListViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Shopping List')),
      body: Builder(
        builder: (context) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: viewModel.loadShoppingList,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          if (!viewModel.hasShoppingList) {
            return const Center(child: Text('No Shopping List available.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: viewModel.shoppingList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final shoppingList = viewModel.shoppingList[index];
              return _ShoppingList(shoppingList: shoppingList);
            },
          );
        },
      ),
    );
  }
}

class _ShoppingList extends StatelessWidget {
  const _ShoppingList({required this.shoppingList});

  final ShoppingList shoppingList;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(shoppingList.title),
        subtitle: Text(shoppingList.description),
      ),
    );
  }
}
