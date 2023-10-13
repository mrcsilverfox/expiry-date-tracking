import 'package:openfoodfacts/openfoodfacts.dart' as op;

/// A mapping of a [OpenFoodFacts]' product
class Product {
  /// {@macro product_item}
  Product.fromOpenFoodProduct(op.Product product)
      : barcode = product.barcode,
        name = product.productName,
        genericName = product.genericName,
        brand = product.brands,
        imageFrontUrl = product.imageFrontUrl,
        imageFrontSmallUrl = product.imageFrontSmallUrl,
        categoriesTags = product.categoriesTags,
        labelsTags = product.labelsTags;

  /// The barcode of the product.
  ///
  /// Cannot be changed.
  final String? barcode;

  /// The name of the product.
  ///
  /// Cannot be changed.
  final String? name;

  /// The generic name of the product.
  ///
  /// Cannot be changed.
  final String? genericName;

  /// The brand of the product.
  ///
  /// Cannot be changed.
  final String? brand;

  /// The image front url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontUrl;

  /// The image front small url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontSmallUrl;

  /// ??
  final List<String>? categoriesTags;

  /// ??
  final List<String>? labelsTags;
}
