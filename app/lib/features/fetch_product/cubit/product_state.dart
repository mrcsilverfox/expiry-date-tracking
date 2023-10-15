part of 'product_cubit.dart';

class ProductState extends BlocSuperState {
  ProductState({required super.status, this.product, super.error});

  ProductState.initial()
      : product = null,
        super.initial();

  final Product? product;

  @override
  List<Object?> get props => [product, ...super.props];

  @override
  ProductState copyWith({
    BlocStateStatus? status,
    Product? product,
  }) {
    return ProductState(
      status: status ?? this.status,
      product: product ?? this.product,
    );
  }

  @override
  ProductState copyWithError(String error) {
    return ProductState(
      status: BlocStateStatus.failure,
      error: error,
      product: product,
    );
  }
}
