part of 'add_product_cubit.dart';

final class AddProductState extends BlocSuperState {
  AddProductState._({
    required this.name,
    required this.brand,
    required this.barcode,
    required this.imageFrontUrl,
    required this.imageFrontSmallUrl,
    required this.expiryDate,
    required this.location,
    required this.quantity,
    required super.status,
    super.error,
  });

  AddProductState.initial(Product product)
      : name = product.name!,
        brand = product.brand,
        barcode = product.barcode!,
        imageFrontSmallUrl = product.imageFrontSmallUrl,
        imageFrontUrl = product.imageFrontUrl,
        expiryDate = null,
        location = null,
        quantity = 1,
        super.initial();

  final String name;

  final String? brand;

  final String barcode;

  /// The image front url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontUrl;

  /// The image front small url of the product.
  ///
  /// Cannot be changed.
  final String? imageFrontSmallUrl;

  /// The expiry date of the product.
  final DateTime? expiryDate;

  /// The quantity of products to be added to the pantry.
  ///
  /// Default value is 1.
  final int quantity;

  /// The location where the product will be positioned.
  final String? location;

  bool get isValid => expiryDate != null && location != null;

  @override
  AddProductState copyWith({
    BlocStateStatus? status,
    DateTime? expiryDate,
    String? location,
    int? quantity,
  }) {
    return AddProductState._(
      name: name,
      brand: brand,
      barcode: barcode,
      imageFrontUrl: imageFrontUrl,
      imageFrontSmallUrl: imageFrontSmallUrl,
      expiryDate: expiryDate ?? this.expiryDate,
      location: location ?? this.location,
      quantity: quantity ?? this.quantity,
      status: status ?? this.status,
      error: null,
    );
  }

  @override
  AddProductState copyWithError(String error) {
    return AddProductState._(
      name: name,
      brand: brand,
      barcode: barcode,
      imageFrontUrl: imageFrontUrl,
      imageFrontSmallUrl: imageFrontSmallUrl,
      expiryDate: expiryDate,
      location: location,
      quantity: quantity,
      status: BlocStateStatus.failure,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        name,
        brand,
        barcode,
        imageFrontUrl,
        imageFrontSmallUrl,
        expiryDate,
        location,
        quantity,
        ...super.props,
      ];

  @override
  String toString() {
    return 'AddProductState('
        'name: $name, '
        'brand: $brand, '
        'barcode: $barcode, '
        'expiryDate: $expiryDate, '
        'quantity: $quantity, '
        'location: $location'
        ')';
  }
}
