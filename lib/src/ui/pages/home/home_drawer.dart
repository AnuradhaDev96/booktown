import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/toggle_theme_bloc.dart';
import '../../../config/app_colors.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
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
                const Divider(),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 2.w, right: 2.w, bottom: 3.h),
                    padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.5.w),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.gradientBlue1, AppColors.gradientBlue2]),
                      borderRadius: BorderRadius.circular(14.sp),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booktown",
                          style: TextStyle(
                            letterSpacing: -2,
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 5, bottom: 3.h),
                          child: Text(
                            'IT, Programming & Computer Science Books',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w400,
                                fontSize: 15.sp,
                                letterSpacing: -0.8,
                                height: 1.2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 4, bottom: 3.h),
                          child: Text(
                            'Platform to browse books covering trending subject in academia. Search your books and keep them safe as favorites.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                              letterSpacing: -0.03,
                              height: 1.1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
