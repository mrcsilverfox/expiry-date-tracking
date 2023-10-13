import 'package:flutter/material.dart';

// ignore: comment_references
/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarItem extends NavigationDestination {
  /// Constructs an [ScaffoldWithNavBarItem].
  const ScaffoldWithNavBarItem({
    required this.rootRoutePath,
    required this.navigatorKey,
    required super.icon,
    required super.label,
    super.key,
  });

  /// The initial location/path
  final String rootRoutePath;

  /// Optional navigatorKey
  final GlobalKey<NavigatorState> navigatorKey;
}
