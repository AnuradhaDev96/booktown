import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dependency_injector.dart';
import 'src/bloc/cubits/toggle_theme_bloc.dart';
import 'src/config/app_routes.dart';
import 'src/config/app_styles.dart';
import 'src/config/widget_keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjector.injectDependencies();

  runApp(const BookTownApp());
}

class BookTownApp extends StatelessWidget {
  const BookTownApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return StreamBuilder<ThemeMode>(
          stream: GetIt.instance<ToggleThemeBloc>().themeModeStream,
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'BookTown',
              debugShowCheckedModeBanner: false,
              theme: AppStyles.lightTheme,
              darkTheme: AppStyles.darkTheme,
              themeMode: snapshot.data ?? ThemeMode.light,
              themeAnimationStyle: AnimationStyle(
                curve: Curves.fastOutSlowIn,
                duration: const Duration(milliseconds: 800),
                reverseDuration: const Duration(milliseconds: 800),
                reverseCurve: Curves.fastOutSlowIn,
              ),
              navigatorKey: WidgetKeys.mainNavKey,
              scaffoldMessengerKey: WidgetKeys.mainScaffoldMessengerKey,
              initialRoute: RouteNames.splashScreen,
              onGenerateRoute: (settings) => RouteConfig.generateRoute(settings),
            );
          }
        );
      }
    );
  }
}
