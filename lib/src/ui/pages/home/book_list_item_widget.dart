import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/fetch_book_details_cubit.dart';
import '../../../bloc/states/fetch_book_details_state.dart';
import '../../../config/alert_utils.dart';
import '../../../config/app_routes.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/book.dart';
import '../../../models/dto/favorite_book_dto.dart';

class BookListItemWidget extends StatelessWidget {
  BookListItemWidget({super.key, required this.bookDto});

  final BookDto bookDto;
  final _fetchDetailsCubit = FetchBookDetailsCubit();

  /// Factory method to build widget using [FavoriteBookDto]
  factory BookListItemWidget.fromFavorites({required FavoriteBookDto favoriteBook}) {
    return BookListItemWidget(
      bookDto: BookDto(
        title: favoriteBook.title,
        subtitle: favoriteBook.subtitle,
        isbn13: favoriteBook.isbn13,
        price: favoriteBook.price,
        image: favoriteBook.price,
        url: favoriteBook.url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchBookDetailsCubit>(
      create: (context) => _fetchDetailsCubit,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          _fetchDetailsCubit.fetchBookDetails(bookDto.isbn13);
          context.loaderOverlay.show();
        },
        child: BlocListener<FetchBookDetailsCubit, BookDetailsState>(
          bloc: _fetchDetailsCubit,
          listener: (BuildContext context, state) {
            if (state is BookDetailsSuccessState) {
              context.loaderOverlay.hide();
              WidgetKeys.mainNavKey.currentState!.pushNamed(
                RouteNames.bookDetailsPage,
                arguments: {'details': state.detailsDto},
              );
            } else if (state is BookDetailsErrorState) {
              context.loaderOverlay.hide();
              AlertUtils.showSnackBar(state.errorMessage, AlertTypes.error);
            }
          },
          child: SizedBox(
            height: 140,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  bookDto.image,
                  width: 20.w,
                  height: 18.w,
                  fit: BoxFit.fitHeight,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(bookDto.title),
                      Text(bookDto.subtitle),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
