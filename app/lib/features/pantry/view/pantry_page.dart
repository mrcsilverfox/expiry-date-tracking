import 'package:app/extensions/extensions.dart';
import 'package:app/routes/routes.dart';
import 'package:flutter/material.dart';

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PantryView();
  }
}

class PantryView extends StatelessWidget {
  const PantryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dispensa'),
        actions: [
          IconButton(
            onPressed: () => context.router.goNamed(AppRoute.scan.name),
            icon: const Icon(Icons.add_rounded),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
