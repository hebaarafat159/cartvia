import 'package:cartvia_project/app/app.dart';
import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:cartvia_project/theme/tokens/app_colors.dart';
import 'package:cartvia_project/theme/tokens/app_sizes.dart';
import 'package:cartvia_project/theme/tokens/app_spacing.dart';
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
              padding: AppSpacing.toggleLabelPadding,
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
                radius: AppSizes.avatarRadius,
                backgroundColor: AppColors.avatarBackground,
                child: Text(
                  localizations.profileInitial,
                  style: const TextStyle(
                    fontSize: AppSizes.profileInitialFont,
                    color: AppColors.textPrimary,
                  ),
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
                AppColors.backgroundGradientTop,
                AppColors.backgroundGradientBottom,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SafeArea(
            top: false,
            child: Padding(
              padding: AppSpacing.pagePadding,
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
                          style: const TextStyle(color: AppColors.error),
                        ),
                        const SizedBox(height: AppSpacing.large),
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
                              fontSize: AppSizes.sectionLabelFont,
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
                    const SizedBox(height: AppSpacing.large),
                    DropdownButtonFormField<String>(
                      value: productsViewModel.selectedListId,
                      isExpanded: true,
                      decoration: InputDecoration(
                        hintText: localizations.shoppingListDropdownHint,
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: AppSpacing.dropdownContentPadding,
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMedium),
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
                    const SizedBox(height: AppSpacing.xxxLarge),
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
