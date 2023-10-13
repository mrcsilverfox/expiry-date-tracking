import 'package:flutter/material.dart';

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({
    required this.child, this.title,
    super.key,
  });

  /// The title of the page
  final String? title;

  /// The child of the page
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: title != null
          ? AppBar(
              title: Text(title!),
            )
          : null,
      body: child,
    );
  }
}
