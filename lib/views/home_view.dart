import 'package:cartvia_project/app/app.dart';
import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:cartvia_project/viewmodels/products_view_model.dart';
import 'package:cartvia_project/viewmodels/shopping_list_view_model.dart';
import 'package:cartvia_project/views/products_list_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final appState = MyApp.of(context);
    final shoppingListViewModel = context.watch<ShoppingListViewModel>();
    final productsViewModel = context.watch<ProductsViewModel>();
    final shoppingLists = shoppingListViewModel.shoppingList;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(localizations.appTitle),
          actions: [
            IconButton(
              onPressed: appState.toggleLocale,
              tooltip: localizations.languageToggleTooltip,
              icon: const Icon(Icons.language),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8),
              child: Center(
                child: Text(
                  isArabic
                      ? localizations.switchToEnglish
                      : localizations.switchToArabic,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: CircleAvatar(
                radius: 26,
                backgroundColor: Colors.grey.shade300,
                child: Text(
                  localizations.profileInitial,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            )
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
                          localizations.unableToLoadShoppingList(
                            shoppingListViewModel.errorMessage!,
                          ),
                          style: const TextStyle(color: Colors.redAccent),
                        ),
                        const SizedBox(height: 12),
                        FilledButton(
                          onPressed: shoppingListViewModel.loadShoppingList,
                          child: Text(localizations.retry),
                        ),
                      ],
                    )
                  else if (shoppingLists.isEmpty)
                    Center(
                      child: Text(localizations.noShoppingListsAvailable),
                    )
                  else
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            localizations.chooseShoppingList,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // TODO handle add new product for a list
                            },
                            tooltip: localizations.addShoppingListTooltip,
                            icon: const Icon(Icons.add),
                          ),
                        ]),
                  if (shoppingLists.isNotEmpty) ...[
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      value: productsViewModel.selectedListId,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: localizations.shoppingListDropdownHint,
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsetsDirectional.symmetric(
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
