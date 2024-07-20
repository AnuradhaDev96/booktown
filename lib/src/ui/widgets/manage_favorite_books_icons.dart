import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cubits/favorite_books_bloc.dart';
import '../../bloc/states/data_payload_state.dart';
import '../../config/alert_utils.dart';
import '../../models/dto/book.dart';

/// This button can be used to remove books from favorites list.
class FavoriteIconButtonFilled extends StatelessWidget {
  FavoriteIconButtonFilled({super.key, required this.isbn});
  final String isbn;

  final RemoveFavoriteBookCubit _removeFavCubit = RemoveFavoriteBookCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _removeFavCubit,
      child: BlocListener(
        bloc: _removeFavCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            AlertUtils.showSnackBar(state.errorMessage, AlertTypes.error);
          } else if (state is SuccessState) {
            AlertUtils.showSnackBar("Removed from favorites", AlertTypes.success);
          }
        },
        child: BlocBuilder<RemoveFavoriteBookCubit, DataPayloadState>(
          bloc: _removeFavCubit,
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                // Call action if current state is not processing. Avoid unnecessary executions
                if (state is! RequestingState) {
                  _removeFavCubit.removeBookFromFavorites(isbn);
                }
              },
              icon: const Icon(CupertinoIcons.heart_fill),
            );
          },
        ),
      ),
    );
  }
}

/// This button can be used to add books to favorites list.
class FavoriteIconButtonOutlined extends StatelessWidget {
  FavoriteIconButtonOutlined({super.key, required this.book});
  final BookDto book;

  final AddFavoriteBookCubit _addFavCubit = AddFavoriteBookCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _addFavCubit,
      child: BlocListener(
        bloc: _addFavCubit,
        listener: (context, state) {
          if (state is ErrorState) {
            AlertUtils.showSnackBar(state.errorMessage, AlertTypes.error);
          } else if (state is SuccessState) {
            AlertUtils.showSnackBar("Marked as favorite", AlertTypes.success);
          }
        },
        child: BlocBuilder<AddFavoriteBookCubit, DataPayloadState>(
          bloc: _addFavCubit,
          builder: (context, state) {
            return IconButton(
              onPressed: () {
                // Call action if current state is not processing. Avoid unnecessary executions
                if (state is! RequestingState) {
                  _addFavCubit.addToFavorites(serverBook: book);
                }
              },
              icon: const Icon(CupertinoIcons.heart),
            );
          },
        ),
      ),
    );
  }
}
