import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'dependency_injector.dart';
import 'src/config/app_routes.dart';
import 'src/config/widget_keys.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DependencyInjector.injectDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'BookTown',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorKey: WidgetKeys.mainNavKey,
          scaffoldMessengerKey: WidgetKeys.mainScaffoldMessengerKey,
          initialRoute: RouteNames.splashScreen,
          onGenerateRoute: (settings) => RouteConfig.generateRoute(settings),
        );
      }
    );
  }
}
