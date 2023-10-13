import 'package:collection/collection.dart';
import 'package:products_api/products_api.dart';

/// {@template memory_products_api}
/// The implementation of the [ProductsApi] with in memory storage.
/// {@endtemplate}
class MemoryProductsApi implements ProductsApi {
  /// {@macro memory_products_api}
  MemoryProductsApi();

  final List<ProductModel> _products = const [];

  @override
  Future<bool> addProduct(covariant ProductModel product) async {
    _products.add(product);
    return true;
  }

  @override
  Future<bool> deleteProduct(String id) async {
    final product = _products.firstWhereOrNull((element) => element.uuid == id);
    final res = _products.remove(product);
    return res;
  }

  @override
  Future<List<ProductModel>> getProducts() async => _products;

  @override
  Future<ProductModel> editProduct(ProductEntity product) async {
    final productToBeEdited = _products.firstWhereOrNull(
      (element) =>
          element.barcode == product.barcode &&
          element.expiryDate == product.expiryDate,
    );
    if (productToBeEdited == null) {
      throw ProductNotFoundException();
    }
    final index = _products.indexOf(productToBeEdited);
    final editedProduct = productToBeEdited.copyWith(
      quantity: productToBeEdited.quantity + product.quantity,
    );
    // The location remains the location of the originally product.
    _products[index] = editedProduct;
    return editedProduct;
  }
}
