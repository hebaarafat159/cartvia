import 'package:cartvia_project/models/shopping_list_model.dart';
import 'package:cartvia_project/theme/tokens/app_spacing.dart';
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
                padding: AppSpacing.dialogPadding,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      viewModel.errorMessage!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xLarge),
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
            padding: AppSpacing.listPadding,
            itemCount: viewModel.shoppingList.length,
            separatorBuilder: (_, __) =>
                const SizedBox(height: AppSpacing.large),
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

  final ShoppingListModel shoppingList;

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
