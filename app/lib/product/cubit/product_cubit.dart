import 'package:app/core/state/bloc_state_status.dart';
import 'package:app/core/state/bloc_super_state.dart';
import 'package:app/product/domain/usecases/usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit(this._fetchProductUserCase) : super(ProductState.initial());

  final FetchProductUseCase _fetchProductUserCase;

  void reset() => emit(ProductState.initial());

  Future<void> fetch(String barcode) async {
    emit(state.copyWith(status: BlocStateStatus.progress));
    final openFoodFactProduct = await _fetchProductUserCase(barcode);
    emit(
      state.copyWith(
        status: BlocStateStatus.success,
        product: openFoodFactProduct,
      ),
    );
  }
}
