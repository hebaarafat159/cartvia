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
                      Padding(
                        padding: AppSpacing.dividerIndent,
                        child: Divider(
                          height: AppSpacing.section,
                          color: AppColors.divider,
                        ),
                      ),
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          _ProductImage(imageUrl: product.primaryImage),
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
        Padding(
          padding: AppSpacing.buttonTopPadding,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isCompact = constraints.maxWidth < 420;

              if (isCompact) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FilledButton(
                      onPressed: () {
                        // TODO handle sharing the selected list or products
                      },
                      child: Text(localizations.shareListAction),
                    ),
                    const SizedBox(height: AppSpacing.large),
                    OutlinedButton(
                      onPressed: () {
                        // TODO handle subscribing to product change updates
                      },
                      child: Text(localizations.notifyChangesAction),
                    ),
                  ],
                );
              }

              return Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        // TODO handle sharing the selected list or products
                      },
                      child: Text(localizations.shareListAction),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.large),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO handle subscribing to product change updates
                      },
                      child: Text(localizations.notifyChangesAction),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(AppSizes.radiusMedium);

    if (imageUrl.isEmpty) {
      return _ProductImagePlaceholder(borderRadius: borderRadius);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      child: Image.network(
        imageUrl,
        width: AppSizes.productImageSize,
        height: AppSizes.productImageSize,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            _ProductImagePlaceholder(borderRadius: borderRadius),
      ),
    );
  }
}

class _ProductImagePlaceholder extends StatelessWidget {
  const _ProductImagePlaceholder({required this.borderRadius});

  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.productImageSize,
      height: AppSizes.productImageSize,
      decoration: BoxDecoration(
        color: AppColors.imagePlaceholderBackground,
        borderRadius: borderRadius,
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: AppColors.textTertiary,
      ),
    );
  }
}
