import 'package:app/app/view/root_screen.dart';
import 'package:app/app/view/widgets/scaffold_with_nav_bar.dart';
import 'package:app/features/add_product/add_product.dart';
import 'package:app/features/pantry/view/pantry_page.dart';
import 'package:app/features/scanner/view/scanner_page.dart';
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
  signUp,
  pantry,
  scan,
  addProduct,
  shop,
}

extension on AppRoute {
  String get path => switch (this) {
        AppRoute.onboarding => 'home',
        AppRoute.signUp => 'sign-up',
        AppRoute.pantry => 'pantry',
        AppRoute.scan => 'scanner',
        AppRoute.addProduct => 'add',
        AppRoute.shop => 'shopping-list',
      };

  String get rootPath => '/$path';
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
              path: AppRoute.pantry.rootPath,
              name: AppRoute.pantry.name,
              pageBuilder: (context, state) => const NoTransitionPage(
                child: PantryPage(),
              ),
              routes: [
                GoRoute(
                  path: AppRoute.scan.path,
                  name: AppRoute.scan.name,
                  parentNavigatorKey: _rootNavigatorKey,
                  pageBuilder: (context, state) {
                    return const MaterialPage(
                      fullscreenDialog: true,
                      child: ScannerPage(),
                    );
                  },
                  routes: [
                    GoRoute(
                      path: AppRoute.addProduct.path,
                      name: AppRoute.addProduct.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) {
                        final product = state.extra! as Product;
                        return BlocProvider(
                          create: (context) => AddProductCubit(
                            product,
                            GetIt.I<ProductsRepository>(),
                          ),
                          child: const AddProductPage(),
                        );
                      },
                      // pageBuilder: (context, state) {
                      //   final product = state.extra! as Product;
                      //   return MaterialPage(
                      //     fullscreenDialog: true,
                      //     child: BlocProvider(
                      //       create: (context) => AddProductCubit(
                      //         product,
                      //         GetIt.I<ProductsRepository>(),
                      //       ),
                      //       child: const AddProductPage(),
                      //     ),
                      //   );
                      // },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        // StatefulShellBranch(
        //   navigatorKey: addProductNavigatorKey,
        //   routes: [
        //     GoRoute(
        //       path: '/add-product',
        //       name: AppRoute.scan.name,
        //       pageBuilder: (context, state) {
        //         return const NoTransitionPage(
        //           child: ScannerPage(),
        //         );
        //       },
        //       routes: [
        //         GoRoute(
        //           path: AppRoute.addProduct.path,
        //           name: AppRoute.addProduct.name,
        //           parentNavigatorKey: _rootNavigatorKey,
        //           pageBuilder: (context, state) {
        //             final product = state.extra! as Product;
        //             return MaterialPage(
        //               fullscreenDialog: true,
        //               child: BlocProvider(
        //                 create: (context) => AddProductCubit(
        //                   product,
        //                   GetIt.I<ProductsRepository>(),
        //                 ),
        //                 child: const AddProductPage(),
        //               ),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        StatefulShellBranch(
          navigatorKey: shoppingNavigatorKey,
          routes: [
            GoRoute(
              path: AppRoute.shop.rootPath,
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
