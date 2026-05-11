import 'package:cartvia_project/viewmodels/products_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsListView extends StatelessWidget {
  const ProductsListView({super.key});

  @override
  Widget build(BuildContext context) {
    final productsViewModel = context.watch<ProductsViewModel>();
    final shoppingList = productsViewModel.selectedShoppingList;

    if (shoppingList == null) {
      return const Center(
        child: Text("Select a shopping list to view its products."),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            "${shoppingList.title} List items",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          IconButton(
            onPressed: () {
              // TODO handle add new product for a list
            },
            icon: const Icon(Icons.add),
          ),
        ]),
        const SizedBox(height: 20),
        Expanded(
          child: productsViewModel.products.isEmpty
              ? const Text("No products available for this shopping list.")
              : ListView.separated(
                  itemCount: productsViewModel.products.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final product = productsViewModel.products[index];
                    final details = [
                      if (product.quantity > 0) '${product.quantity}',
                      if (product.measurement.isNotEmpty) product.measurement,
                    ].join(' ');

                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 36,
                            height: 36,
                            child: Checkbox(
                              value: product.bring,
                              activeColor: const Color(0xFFB84E2A),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
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
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                if (product.description.isNotEmpty ||
                                    details.isNotEmpty)
                                  const SizedBox(height: 4),
                                if (product.description.isNotEmpty)
                                  Text(
                                    product.description,
                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                if (details.isNotEmpty)
                                  Text(
                                    details,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
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
