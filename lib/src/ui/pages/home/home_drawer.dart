import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 3.h),
                child: Text(
                  'Change theme',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
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
            const Divider()
          ],
        ),
      ),
    );
  }
}
