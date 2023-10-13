import 'package:collection/collection.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/src/products_repository_state.dart';
import 'package:rxdart/rxdart.dart';

/// {@template products_repository}
/// A repository that handles `product` related requests.
/// {@endtemplate}
class ProductsRepository {
  /// {@macro products_repository}
  ProductsRepository({required ProductsApi productsApi})
      : _productsApi = productsApi;

  final ProductsApi _productsApi;

  final _productsStreamController =
      BehaviorSubject<ProductsRepositoryState>.seeded(
    ProductsRepositoryInitial(),
  );

  ///
  Stream<ProductsRepositoryState> get states =>
      _productsStreamController.asBroadcastStream();

  /// A map of the [ProductEntity]s loaded in the memory.
  ///
  /// The key is the UUID of the [ProductEntity].
  Map<String, ProductEntity> _productsMap = {};

  /// The list of products currently loaded in memory in the repository.
  List<ProductEntity> get products => [..._productsMap.values];

  Future<void> fetchProducts() async {
    final products = await _productsApi.getProducts();
    _productsMap = {for (final p in products) p.uuid: p};
  }

  ProductEntity? _getProduct(bool Function(ProductEntity) test) =>
      products.firstWhereOrNull(test);

  // add map of the products in the repository. Gets the products from the data
  //sources, and sync the storage

  /// Provides a [List] of all products.
  //List<ProductEntity> getProducts() => _productsApi.getProducts();

  /// Adds a [product].
  ///
  /// If a [product] with the same barcode and same expiry date already exists,
  /// the quantity of the product is increment by product quantity.
  Future<void> addOrEditProduct(ProductEntity product) async {
    final exist = _getProduct(
      (element) =>
          element.barcode == product.barcode &&
          element.expiryDate == product.expiryDate,
    );
    if (exist == null) {
      try {
        final res = await _productsApi.addProduct(product);
        if (res) {
          _productsMap[product.uuid] = product;
          _productsStreamController
              .add(ProductsRepositoryProductAdded(product));
        }
      } catch (e) {}
    } else {
      try {
        final editedProduct = await _productsApi.editProduct(product);
        _productsMap[product.uuid] = editedProduct;
        _productsStreamController.add(
          ProductsRepositoryProductEdited(exist, editedProduct),
        );
      } catch (e) {}
    }
  }

  /// Deletes a `product` with the given [uuid].
  Future<bool> deleteProduct(String uuid) async {
    // final product = _getProduct((p) => p.uuid == uuid);
    try {
      final res = await _productsApi.deleteProduct(uuid);
      if (res) {
        // exist a product with the given [uuid]
        final product = _productsMap[uuid]!;
        _productsMap.remove(uuid);
        _productsStreamController
            .add(ProductsRepositoryProductDeleted(product));
      }
      return res;
    } catch (e) {
      return false;
    }
  }
}
