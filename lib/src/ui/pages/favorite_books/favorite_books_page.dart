import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../config/alert_utils.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/favorite_book_dto.dart';
import '../../widgets/book_list_shimmer_widget.dart';
import '../../widgets/empty_list_placeholder_widget.dart';
import '../../widgets/list_seperator_widget.dart';
import '../home/book_list_item_widget.dart';

class FavoriteBooksPage extends StatelessWidget {
  const FavoriteBooksPage({super.key});

  @override
  Widget build(BuildContext context) {
    GetIt.instance<FavoriteBooksBloc>().retrieveFavoriteBookList();
    return LoaderOverlay(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          leadingWidth: 20.w,
          leading: Padding(
            padding: EdgeInsets.only(left: 2.w),
            child: TextButton.icon(
              onPressed: () => WidgetKeys.mainNavKey.currentState!.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 16,
              ),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
            ),
          ),
          title: const Text("Favorites"),
        ),
        body: StreamBuilder<List<FavoriteBookDto>>(
          stream: GetIt.instance<FavoriteBooksBloc>().favoriteBooksStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ShimmerListWidget(
                padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 3.w, right: 3.w),
                itemCount: 10,
              );
            }

            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 3.w, right: 3.w),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      BookListItemWidget.fromFavorites(favoriteBook: snapshot.data![index]),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: (context, index) => const ListSeparatorWidget(),
                );
              } else {
                return const EmptyListPlaceholderWidget(message: AlertMessages.favoriteBooksNotFound);
              }
            }

            return const EmptyListPlaceholderWidget(message: AlertMessages.errorFetchingFavoriteBooks);
          },
        ),
      ),
    );
  }
}
