import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// {@template product_entity_item}
/// A single `product` item.
///
/// Contains a [name], [brand], [barcode], [imageFrontUrl], ...
///
/// The [uuid] is generated by the constructor, it cannot be empty.
///
/// [ProductEntity]s are immutable and can be copied using [copyWith],
/// in addition to being serialized and deserialized using [toJson] and [fromJson]
/// respectively.
/// {@endtemplate}

class ProductEntity extends Equatable {
  /// {@macro product_entity_item}
  ProductEntity({
    required this.barcode,
    required this.quantity,
    required this.name,
    required this.expiryDate,
    required this.location,
    this.brand,
    this.imageFrontUrl,
    this.imageFrontSmallUrl,
  }) : uuid = const Uuid().v4();

  /// The identifier of the product.
  ///
  /// Two products with same [barcode] will have the different [uuid].
  final String uuid;

  /// The barcode of the product.
  ///
  /// Cannot be changed.
  final String barcode;

  /// The name of the product.
  ///
  /// Cannot be changed.
  final String? name;

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

  /// The expiry date of the product.
  final DateTime expiryDate;

  /// The quantity of products to be added to the pantry.
  ///
  /// Default value is 1.
  final int quantity;

  /// The location where the product will be positioned.
  final String location;

  /// Returns a copy of this `product` with the given values updated.
  ///
  /// {@macro product_entity_item}
  ProductEntity copyWith({
    DateTime? expiryDate,
    int? quantity,
    String? location,
  }) {
    return ProductEntity(
      name: name,
      brand: brand,
      barcode: barcode,
      imageFrontUrl: imageFrontUrl,
      imageFrontSmallUrl: imageFrontSmallUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
    );
  }

  @override
  List<Object?> get props => [
        uuid,
        barcode,
        name,
        brand,
        imageFrontUrl,
        imageFrontSmallUrl,
        quantity,
        expiryDate,
        location,
      ];

  @override
  String toString() {
    return 'ProductEntity('
        'uuid: $uuid, '
        'barcode: $barcode, '
        'name: $name, '
        'brand: $brand, '
        'imageFrontUrl: $imageFrontUrl, '
        'imageFrontSmallUrl: $imageFrontSmallUrl, '
        'quantity: $quantity, '
        'expiryDate: $expiryDate, '
        'location: $location'
        ')';
  }
}