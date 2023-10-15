import 'package:app/app/view/root_screen.dart';
import 'package:app/app/view/widgets/scaffold_with_nav_bar.dart';
import 'package:app/features/add_product/add_product.dart';
import 'package:app/features/scanner/view/qr_code_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:open_food_facts_api_repository/open_food_facts_api_repository.dart';
import 'package:products_repository/products_repository.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final pantryNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'pantryNav');
final addProductNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'addProductNav');
final shoppingNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shoppingNav');

enum AppRoute {
  onboarding,
  signIn,
  pantry,
  scan,
  addProduct,
  shop,
}

final router = GoRouter(
  initialLocation: '/pantry',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // GoRoute(
    //   path: '/onboarding',
    //   name: AppRoute.onboarding.name,
    //   pageBuilder: (context, state) => const NoTransitionPage(
    //     child: OnboardingScreen(),
    //   ),
    // ),
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: pantryNavigatorKey,
          routes: [
            GoRoute(
              path: '/pantry',
              name: AppRoute.pantry.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(
                  title: 'Dispensa',
                  child: Placeholder(),
                ),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: addProductNavigatorKey,
          routes: [
            GoRoute(
              path: '/add-product',
              name: AppRoute.scan.name,
              pageBuilder: (context, state) {
                return const NoTransitionPage(
                  child: QrCodeScannerPage(),
                );
              },
              routes: [
                GoRoute(
                  path: 'add',
                  name: AppRoute.addProduct.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) {
                    final product = state.extra! as Product;
                    return MaterialPage(
                      fullscreenDialog: true,
                      child: BlocProvider(
                        create: (context) => AddProductCubit(
                          product,
                          GetIt.I<ProductsRepository>(),
                        ),
                        child: const AddProductPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: shoppingNavigatorKey,
          routes: [
            GoRoute(
              path: '/shopping-list',
              name: AppRoute.shop.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: RootScreen(
                  title: 'Lista della spesa',
                  child: Placeholder(),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  //errorBuilder: (context, state) => const NotFoundScreen(),
);
