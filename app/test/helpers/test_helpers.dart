import 'package:app/features/fetch_product/fetch_product.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';

@GenerateMocks(
  [FetchProductUseCase, OpenFoodFactsApiRepository],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
