import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../bloc/cubits/fetch_book_details_cubit.dart';
import '../../../bloc/states/data_payload_state.dart';
import '../../../bloc/states/fetch_book_details_state.dart';
import '../../../config/alert_utils.dart';
import '../../../config/app_routes.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/book.dart';
import '../../../models/dto/favorite_book_dto.dart';
import '../../widgets/manage_favorite_books_icons.dart';

class BookListItemWidget extends StatelessWidget {
  BookListItemWidget({super.key, required this.bookDto});

  final BookDto bookDto;
  final _fetchDetailsCubit = FetchBookDetailsCubit();
  final _removeFromFavCubit = RemoveFavoriteBookCubit();
  final _addToFavCubit = AddFavoriteBookCubit();

  /// Factory method to build widget using [FavoriteBookDto]
  factory BookListItemWidget.fromFavorites({required FavoriteBookDto favoriteBook}) {
    return BookListItemWidget(
      bookDto: BookDto(
        title: favoriteBook.title,
        subtitle: favoriteBook.subtitle,
        isbn13: favoriteBook.isbn13,
        price: favoriteBook.price,
        image: favoriteBook.image,
        url: favoriteBook.url,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchBookDetailsCubit>(create: (context) => _fetchDetailsCubit),
        BlocProvider<RemoveFavoriteBookCubit>(create: (context) => _removeFromFavCubit),
        BlocProvider<AddFavoriteBookCubit>(create: (context) => _addToFavCubit),
      ],
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onDoubleTap: () {
          if (GetIt.instance<FavoriteBooksBloc>().favoriteBooksValue.any((fav) => fav.isbn13 == bookDto.isbn13)) {
            _removeFromFavCubit.removeBookFromFavorites(bookDto.isbn13);
          } else {
            _addToFavCubit.addToFavorites(serverBook: bookDto);
          }
        },
        onTap: () {
          _fetchDetailsCubit.fetchBookDetails(bookDto.isbn13);
          context.loaderOverlay.show();
        },
        child: MultiBlocListener(
          listeners: [
            BlocListener<FetchBookDetailsCubit, BookDetailsState>(
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
            ),
            BlocListener(
              bloc: _removeFromFavCubit,
              listener: (context, state) {
                if (state is ErrorState) {
                  AlertUtils.showSnackBar(state.errorMessage, AlertTypes.error);
                } else if (state is SuccessState) {
                  showHeartAnimation(CupertinoIcons.heart_slash, context);
                }
              },
            ),
            BlocListener(
              bloc: _addToFavCubit,
              listener: (context, state) {
                if (state is ErrorState) {
                  AlertUtils.showSnackBar(state.errorMessage, AlertTypes.error);
                } else if (state is SuccessState) {
                  showHeartAnimation(CupertinoIcons.heart_fill, context);
                }
              },
            ),
          ],
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
                      Text(bookDto.title, style: Theme.of(context).textTheme.titleMedium),
                      Text(bookDto.subtitle),
                    ],
                  ),
                ),
                StreamBuilder<List<FavoriteBookDto>>(
                  stream: GetIt.instance<FavoriteBooksBloc>().favoriteBooksStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      final currentFavoriteList = snapshot.data!;
                      if (currentFavoriteList.any((fav) => fav.isbn13 == bookDto.isbn13)) {
                        return FavoriteIconButtonFilled(isbn: bookDto.isbn13);
                      } else {
                        return FavoriteIconButtonOutlined(book: bookDto);
                      }
                    } else {
                      return IconButton(
                        onPressed: () {},
                        icon: const Icon(CupertinoIcons.heart),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showHeartAnimation(IconData icon, BuildContext context) {
    context.loaderOverlay.show(
      showOverlay: false,
      widgetBuilder: (_) => Icon(
        icon,
        size: 60.sp,
      ),
    );
    Future.delayed(
      const Duration(milliseconds: 1800),
      () {
        context.loaderOverlay.hide();
      },
    );
  }
}
