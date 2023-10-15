import 'package:app/features/fetch_product/fetch_product.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:openfoodfacts/openfoodfacts.dart' as op;


class MockOpenFoodFactsApiRepository extends Mock
    implements OpenFoodFactsApiRepository {}

void main() {
  late final FetchProductUseCase _useCase;

  late final MockOpenFoodFactsApiRepository _repo;

  const testBarcode = '00000';

  final opProduct = op.Product(
    barcode: '00000',
    productName: 'P1',
    brands: 'Brand1',
  );
  final testProduct = Product.fromOpenFoodProduct(opProduct);

  setUp(() {
    _repo = MockOpenFoodFactsApiRepository();
    _useCase = FetchProductUseCase(_repo);
  });

   test('should get product details from barcode', () async {
    // arrange
    when(() => _repo.fetchProduct(testBarcode)).thenAnswer(
      (_) async => testProduct,
    );

    // act
    final result = await _useCase.call(testBarcode);
    // assert
    expect(result, testProduct);
  });
}
