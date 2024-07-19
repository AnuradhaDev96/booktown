import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 11.h,
        flexibleSpace: HomeAppBar(),
      ),
    );
  }
}
