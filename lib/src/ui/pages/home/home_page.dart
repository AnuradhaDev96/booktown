import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/switch_list_mode.dart';
import 'book_list_widget.dart';
import 'book_search_results_widget.dart';
import 'home_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchBookListModeCubit>(
      create: (context) => SwitchBookListModeCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 11.h,
          flexibleSpace: HomeAppBar(),
        ),
        body: BlocBuilder<SwitchBookListModeCubit, bool>(
          builder: (context, isListMode) {
            return isListMode ? BookListWidget() : const BookSearchResultsWidget();
          }
        ),
      ),
    );
  }
}
