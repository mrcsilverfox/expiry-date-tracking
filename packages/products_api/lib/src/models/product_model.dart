import 'package:openfoodfacts/openfoodfacts.dart' as op;
import 'package:products_api/src/models/product_entity.dart';

/// The implementation of the [ProductEntity]
class ProductModel extends ProductEntity {
  /// The private constructor for the [ProductModel].
  ///
  /// A product must be created from an [OpenFoodFacts]' product.
  ProductModel._({
    required super.barcode,
    required super.quantity,
    required super.name,
    required super.expiryDate,
    required super.location,
    super.brand,
    super.imageFrontUrl,
    super.imageFrontSmallUrl,
  });

  /// Create a new product entity from an open food facts product.
  ///
  /// Before call this construcor check if the [barcode] of the [product] is
  /// not null.
  factory ProductModel.fromOpenFoodProduct(
    op.Product product, {
    required int quantity,
    required DateTime expiryDate,
    required String location,
  }) {
    return ProductModel._(
      barcode: product.barcode!,
      name: product.productName,
      brand: product.brands,
      imageFrontUrl: product.imageFrontUrl,
      imageFrontSmallUrl: product.imageFrontSmallUrl,
      quantity: quantity,
      expiryDate: expiryDate,
      location: location,
    );
  }

  @override
  ProductModel copyWith({
    DateTime? expiryDate,
    int? quantity,
    String? location,
  }) {
    return ProductModel._(
      barcode: barcode,
      name: name,
      brand: brand,
      imageFrontUrl: imageFrontUrl,
      imageFrontSmallUrl: imageFrontSmallUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
    );
  }
}
