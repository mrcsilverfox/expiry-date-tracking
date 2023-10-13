
import 'package:app/app/view/widgets/scaffold_with_nav_bar.dart';
import 'package:app/app/view/widgets/scaffold_with_nav_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// ShellRoute that uses a bottom tab navigation (ScaffoldWithNavBar) with
/// separate navigators for each tab.
///
/// NOTE: This is not an optimal implementation and should ideally be
/// implemented in go_router, although in a way that doesn't use a navigator.
/// Here is a proposed implementation:
/// https://github.com/tolo/flutter_packages/tree/nested-persistent-navigation/packages/go_router
class BottomBarShellRoute extends ShellRoute {
  BottomBarShellRoute({
    required this.tabs,
    super.navigatorKey,
    super.routes = const <RouteBase>[],
    Key? scaffoldKey = const ValueKey('ScaffoldWithNavBar'),
  }) : super(
          builder: (context, state, Widget fauxNav) {
            return Stack(
              children: [
                // Needed to keep the (faux) shell navigator alive
                Offstage(child: fauxNav),
                ScaffoldWithNavBar(
                  tabs: tabs,
                  key: scaffoldKey,
                  currentNavigator:
                      (fauxNav as HeroControllerScope).child as Navigator,
                  currentRouterState: state,
                  routes: routes,
                ),
              ],
            );
          },
        );
  final List<ScaffoldWithNavBarItem> tabs;
}
