import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/cubits/switch_list_mode_cubit.dart';
import '../../../config/widget_keys.dart';
import 'book_list_widget.dart';
import 'book_search_results_widget.dart';
import 'home_app_bar.dart';
import 'home_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // Get favorite books from local db
      GetIt.instance<FavoriteBooksBloc>().retrieveFavoriteBookList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SwitchBookListModeCubit>(create: (context) => SwitchBookListModeCubit()),
        BlocProvider<SearchBookResultCubit>(create: (context) => SearchBookResultCubit()),
      ],
      child: LoaderOverlay(
        child: Scaffold(
          key: WidgetKeys.homePageKey,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 9.h,
            backgroundColor: Theme.of(context).cardColor,
            surfaceTintColor: Theme.of(context).cardColor,
            flexibleSpace: HomeAppBar(),
            elevation: 10,
          ),
          body: BlocBuilder<SwitchBookListModeCubit, bool>(builder: (context, isListMode) {
            return isListMode ? BookListWidget() : const BookSearchResultsWidget();
          }),
          drawer: const HomeDrawer(),
        ),
      ),
    );
  }
}
