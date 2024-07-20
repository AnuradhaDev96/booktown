import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../bloc/cubits/toggle_theme_bloc.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            StreamBuilder<ThemeMode>(
                stream: GetIt.instance<ToggleThemeBloc>().themeModeStream,
                builder: (context, snapshot) {
                  return SwitchListTile(
                    title: const Text("Dark mode"),
                    value: (snapshot.data ?? ThemeMode.light) == ThemeMode.dark,
                    onChanged: (value) {
                      GetIt.instance<ToggleThemeBloc>().updateTheme(isDarkMode: value);
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }
}
