import 'package:cartvia_project/l10n/app_localizations.dart';
import 'package:cartvia_project/theme/tokens/app_colors.dart';
import 'package:cartvia_project/theme/tokens/app_sizes.dart';
import 'package:cartvia_project/theme/tokens/app_spacing.dart';
import 'package:cartvia_project/viewmodels/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final productsViewModel = context.watch<ProductsViewModel>();
    final shoppingList = productsViewModel.selectedShoppingList;

    if (shoppingList == null) {
      return Center(
        child: Text(localizations.selectShoppingListToViewProducts),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            localizations.shoppingListItemsTitle(shoppingList.title),
            style: const TextStyle(
              fontSize: AppSizes.sectionLabelFont,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO handle add new product for a list
            },
            tooltip: localizations.addProductTooltip,
            icon: const Icon(Icons.add),
          ),
        ]),
        const SizedBox(height: AppSpacing.xxxLarge),
        Expanded(
          child: productsViewModel.products.isEmpty
              ? Text(localizations.noProductsAvailableForShoppingList)
              : ListView.separated(
                  itemCount: productsViewModel.products.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.large),
                  itemBuilder: (context, index) {
                    final product = productsViewModel.products[index];
                    final details = [
                      if (product.quantity > 0) '${product.quantity}',
                      if (product.measurement.isNotEmpty) product.measurement,
                    ].join(' ');

                    return Container(
                      padding: AppSpacing.cardPadding,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius:
                            BorderRadius.circular(AppSizes.radiusLarge),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: AppSizes.checkboxSize,
                            height: AppSizes.checkboxSize,
                            child: Checkbox(
                              value: product.bring,
                              activeColor: AppColors.primaryAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(AppSizes.radiusSmall),
                              ),
                              onChanged: (value) {
                                if (value == null) return;
                                productsViewModel.setProductBring(
                                  productId: product.id,
                                  bring: value,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: AppSpacing.large),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: AppSizes.sectionLabelFont,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product.description.isNotEmpty ||
                                    details.isNotEmpty)
                                  const SizedBox(height: AppSpacing.xSmall),
                                if (product.description.isNotEmpty)
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                if (details.isNotEmpty)
                                  Text(
                                    details,
                                    style: TextStyle(
                                      color: AppColors.textTertiary,
                                      fontSize: AppSizes.bodySmallFont,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
