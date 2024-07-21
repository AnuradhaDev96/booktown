import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/cubits/switch_list_mode_cubit.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_routes.dart';
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
  Rect? rect;
  late final GlobalKey<RectGetterState> heartIconRectKey = RectGetter.createGlobalKey();

  // durations
  final animationDuration = const Duration(milliseconds: 1500);
  final navigationDelay = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    // heartIconRectKey = RectGetter.createGlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((timestamp) {
      // Get favorite books from local db
      GetIt.instance<FavoriteBooksBloc>().retrieveFavoriteBookList();
    });
  }

  void onHeartButtonPressed() {
    setState(() {
      rect = RectGetter.getRectFromKey(heartIconRectKey);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        rect = rect!.inflate(1.3 * MediaQuery.sizeOf(context).longestSide);
        Future.delayed(animationDuration + navigationDelay, navigateNextPage);
      });
    });
  }

  void navigateNextPage() {
    setState(() {
      rect = null;
    });
    WidgetKeys.mainNavKey.currentState!.pushNamed(RouteNames.favoriteBooksPage);
  }

  Widget get ripple {
    if (rect == null) {
      return const SizedBox.shrink();
    } else {
      return AnimatedPositioned(
        duration: animationDuration,
        curve: Curves.slowMiddle,
        left: rect!.left,
        top: rect!.top,
        right: MediaQuery.sizeOf(context).width - rect!.right,
        bottom: MediaQuery.sizeOf(context).width - rect!.bottom,
        child: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [AppColors.gradientBlue1, AppColors.gradientBlue2],
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SwitchBookListModeCubit>(create: (context) => SwitchBookListModeCubit()),
        BlocProvider<SearchBookResultCubit>(create: (context) => SearchBookResultCubit()),
      ],
      child: LoaderOverlay(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Scaffold(
              key: WidgetKeys.homePageKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                toolbarHeight: 9.h,
                backgroundColor: Theme.of(context).cardColor,
                surfaceTintColor: Theme.of(context).cardColor,
                flexibleSpace: HomeAppBar(
                  onHeartButtonPressed: onHeartButtonPressed,
                  heartIconRectKey: heartIconRectKey,
                ),
                elevation: 10,
              ),
              body: BlocBuilder<SwitchBookListModeCubit, bool>(builder: (context, isListMode) {
                return isListMode ? BookListWidget() : const BookSearchResultsWidget();
              }),
              drawer: const HomeDrawer(),
            ),
            ripple,
          ],
        ),
      ),
    );
  }
}
