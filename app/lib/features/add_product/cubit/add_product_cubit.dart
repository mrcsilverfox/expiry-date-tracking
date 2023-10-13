import 'package:app/core/state/bloc_state_status.dart';
import 'package:app/core/state/bloc_super_state.dart';
import 'package:bloc/bloc.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit(this.product, this._repo)
      : super(
          AddProductState.initial(product),
        );

  final Product product;
  final ProductsRepository _repo;

  Future<void> add() async {
    // use reposotory and optional use case do add the product
    print(state);
    return;
    if (state.isValid) {
      final product = ProductEntity(
        name: state.name,
        brand: state.brand,
        barcode: state.barcode,
        imageFrontUrl: state.imageFrontUrl,
        imageFrontSmallUrl: state.imageFrontSmallUrl,
        expiryDate: state.expiryDate!,
        quantity: state.quantity,
        location: state.location!,
      );
      emit(state.copyWith(status: BlocStateStatus.progress));
      try {
        await _repo.addOrEditProduct(product);
        emit(state.copyWith(status: BlocStateStatus.success));
      } catch (e, s) {
        emit(state.copyWithError(e.toString()));
      }
    } else {
      // FIXME: use a field validator
      emit(state.copyWithError('Inserisci i campi richiesti'));
    }
  }

  void onDateTimeChanged(DateTime dateTime) {
    if (state.expiryDate != dateTime) {
      emit(state.copyWith(expiryDate: dateTime));
    }
  }

  void onLocationChanged(String location) {
    if (state.location != location) {
      emit(state.copyWith(location: location));
    }
    print(state);
  }

  void onQuantityChanged(int quantity) {
    if (state.quantity != quantity) {
      emit(state.copyWith(quantity: quantity));
    }
  }
}
