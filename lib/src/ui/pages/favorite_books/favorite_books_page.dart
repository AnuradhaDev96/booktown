import 'package:flutter/material.dart';

import '../../../config/widget_keys.dart';

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: TextButton.icon(
          onPressed: () => WidgetKeys.mainNavKey.currentState!.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
          ),
          label: const Text('Back'),
          style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
        ),
        title: const Text("Favorites"),
      ),
    );
  }
}
