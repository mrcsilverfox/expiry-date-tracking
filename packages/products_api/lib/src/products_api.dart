import 'package:products_api/src/models/product_entity.dart';

/// {@template products_api}
/// The interface for an API that provides access to a list of products.
/// {@endtemplate}
abstract class ProductsApi {
  /// {@macro products_api}
  const ProductsApi();

  /// Provides a [List] of all products.
  Future<List<ProductEntity>> getProducts();

  /// Saves a [product].
  ///
  /// If a [product] with the same barcode already exists, its quantity is
  /// incremented by 1.
  Future<bool> addProduct(ProductEntity product);

  /// Edits an exisiting [product].
  ///
  /// If a [product] with the same barcode and same expiry date already exists,
  /// its quantity is incremented by product quantity.
  ///
  /// It returns the previous product and the edited product.
  Future<ProductEntity> editProduct(ProductEntity product);

  /// Deletes the `product` with the given id.
  ///
  /// If no `product` with the given id exists, a [ProductNotFoundException]
  /// error is thrown.
  Future<bool> deleteProduct(String id);
}

/// Error thrown when a [ProductEntity] with a given barcode is not found.
class ProductNotFoundException implements Exception {}
