import 'package:openfoodfacts/openfoodfacts.dart';

/// Exception thrown when get product fails.
class ProductNotFound implements Exception {}

/// {@template open_food_facts_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class OpenFoodFactsApiClient {
  /// {@macro open_food_facts_api}
  const OpenFoodFactsApiClient();

  void configure() {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Expired date tracking',
    );
    OpenFoodAPIConfiguration.globalLanguages = <OpenFoodFactsLanguage>[
      OpenFoodFactsLanguage.ITALIAN,
    ];
  }

  Future<Product> fetchProduct(String barcode) async {
    final config = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final result = await OpenFoodAPIClient.getProductV3(config);
    if (result.product == null) throw ProductNotFound();
    return result.product!;
  }
}
