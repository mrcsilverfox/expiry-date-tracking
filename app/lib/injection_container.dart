import 'package:app/features/fetch_product/fetch_product.dart';
import 'package:get_it/get_it.dart';
import 'package:memory_products_api/memory_products_api.dart';
import 'package:open_food_facts_api/open_food_facts_api.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';
import 'package:products_api/products_api.dart';
import 'package:products_repository/products_repository.dart';

void initializeDependencies() {
  // Dependencies
  final openFoodFactsApiClient = const OpenFoodFactsApiClient()..configure();

  GetIt.I.registerSingleton<OpenFoodFactsApiClient>(openFoodFactsApiClient);

  GetIt.I.registerSingleton<OpenFoodFactsApiRepository>(
    OpenFoodFactsApiRepository(GetIt.I()),
  );

  GetIt.I.registerSingleton<ProductsApi>(MemoryProductsApi());

  GetIt.I.registerSingleton<ProductsRepository>(
    ProductsRepository(productsApi: GetIt.I()),
  );

  // Use Cases
  GetIt.I.registerSingleton<FetchProductUseCase>(
    FetchProductUseCase(GetIt.I()),
  );

  // Blocs
  GetIt.I.registerFactory<ProductCubit>(() => ProductCubit(GetIt.I()));
}
