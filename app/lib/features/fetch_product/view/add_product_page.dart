import 'package:flutter/material.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return AddProductView(product: product);
  }
}

class AddProductView extends StatelessWidget {
  const AddProductView({required this.product, super.key});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // FIXME: l10n
        title: const Text('Aggiungi prodotto'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 10,
          left: 10,
          top: 10,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  product.imageFrontSmallUrl!,
                  width: 100,
                  height: 100,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(product.name ?? 'No name'),
                      Text(product.brand ?? 'No name'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
