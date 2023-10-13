import 'package:products_api/products_api.dart';

///
abstract class ProductsRepositoryState {}

///
class ProductsRepositoryInitial extends ProductsRepositoryState {}

/// State when a product is added in the repository.
class ProductsRepositoryProductAdded extends ProductsRepositoryState {
  ///
  ProductsRepositoryProductAdded(this.product);

  /// The product added in the repository.
  final ProductEntity product;
}

/// State when a product is delete from the repository.
class ProductsRepositoryProductDeleted extends ProductsRepositoryState {
  ///
  ProductsRepositoryProductDeleted(this.product);

  /// The product deleted from the repository.
  final ProductEntity product;
}

/// State when a product is edited in the repository.
class ProductsRepositoryProductEdited extends ProductsRepositoryState {
  ///
  ProductsRepositoryProductEdited(this.previousProduct, this.updatedProduct);

  /// The previous product in the repository.
  final ProductEntity previousProduct;

  /// The product updated in the repository.
  final ProductEntity updatedProduct;
}
