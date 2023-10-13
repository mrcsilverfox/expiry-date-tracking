import 'package:open_food_facts_api/open_food_facts_api.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';

/// {@template open_food_facts_api_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class OpenFoodFactsApiRepository {
  /// {@macro open_food_facts_api_repository}
  const OpenFoodFactsApiRepository(this._client);

  final OpenFoodFactsApiClient _client;

  Future<Product?> fetchProduct(String barcode) async {
    try {
      final product = await _client.fetchProduct(barcode);
      return Product.fromOpenFoodProduct(product);
    } catch (e) {
      return null;
    }
  }
}
