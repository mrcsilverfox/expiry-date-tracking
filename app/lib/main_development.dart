

// void main() {
//   initializeDependencies();
//   bootstrap(() => const App());
// }

// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:app/app/app.dart';
import 'package:app/bootstrap.dart';
import 'package:app/injection_container.dart';
import 'package:app/scanner/view/qr_code_scanner_page.dart';
import 'package:flutter/material.dart';

// // This example demonstrates how to setup nested navigation using a
// // BottomNavigationBar, where each tab uses its own persistent navigator, i.e.
// // navigation state is maintained separately for each tab. This setup also
// // enables deep linking into nested pages.
// //
// // This example demonstrates how to display routes within a ShellRoute using a
// // `nestedNavigationBuilder`. Navigators for the tabs ('Section A' and
// // 'Section B') are created via nested ShellRoutes. Note that no navigator will
// // be created by the "top" ShellRoute. This example is similar to the ShellRoute
// // example, but differs in that it is able to maintain the navigation state of
// // each tab.

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencies();
  // bootstrap(
  //   () => const MaterialApp(
  //     home: MyHome(),
  //   ),
  // );
  //bootstrap(App.new);
  bootstrap(App.new);
}

// FIXME: to be moved
/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    this.param,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  final String? param;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (widget.param != null)
              Text(
                'Parameter: ${widget.param!}',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            const Padding(padding: EdgeInsets.all(4)),
            Text(
              'Details for ${widget.label} - Counter: $_counter',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const BarcodeScannerWithController(),
                  ),
                );
              },
              child: const Text('MobileScanner with Controller'),
            ),
          ],
        ),
      ),
    );
  }
}
