import 'package:app/app/view/widgets/scaffold_with_nav_bar_item.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
    // return MaterialApp(
    //   theme: ThemeData(
    //     appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
    //     colorScheme: ColorScheme.fromSwatch(
    //       accentColor: const Color(0xFF13B9FF),
    //     ),
    //   ),
    //   localizationsDelegates: AppLocalizations.localizationsDelegates,
    //   supportedLocales: AppLocalizations.supportedLocales,
    //   home: const Placeholder(),
    // );
  }
}

/// An example demonstrating how to use nested navigators
class NestedTabNavigationExampleApp extends StatelessWidget {
  /// Creates a NestedTabNavigationExampleApp
  const NestedTabNavigationExampleApp({super.key});

  static final List<ScaffoldWithNavBarItem> tabs = <ScaffoldWithNavBarItem>[
    ScaffoldWithNavBarItem(
      rootRoutePath: '/pantry',
      navigatorKey: pantryNavigatorKey,
      icon: const Icon(Icons.home),
      label: 'Dispensa',
    ),
    ScaffoldWithNavBarItem(
      rootRoutePath: '/add-product',
      navigatorKey: addProductNavigatorKey,
      icon: const Icon(Icons.scanner),
      label: 'Aggiungi',
    ),
    ScaffoldWithNavBarItem(
      rootRoutePath: '/shopping-list',
      navigatorKey: shoppingNavigatorKey,
      icon: const Icon(Icons.shop),
      label: 'Lista spesa',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
