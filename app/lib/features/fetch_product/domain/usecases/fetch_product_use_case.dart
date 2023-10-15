import 'package:app/core/usecases/usecase.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';

// class FetchProductUseCase implements UseCase<ProductEntity?, String> {

//   const FetchProductUseCase(this._productRepository);
//   final ProductRepository _productRepository;

//   @override
//   Future<ProductEntity?> call(String param) {
//     return _productRepository.fetchProduct(param);
//   }
// }

class FetchProductUseCase implements UseCase<Product?, String> {

  const FetchProductUseCase(this._repository);
  final OpenFoodFactsApiRepository _repository;

  @override
  Future<Product?> call(String param) {
    return _repository.fetchProduct(param);
  }
}
