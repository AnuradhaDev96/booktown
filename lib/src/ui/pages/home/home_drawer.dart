import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SwitchListTile(
              title: const Text("Dark mode"),
              value: true,
              onChanged: (value) {},
            ),
          ],
        ),
      ),
    );
  }
}
