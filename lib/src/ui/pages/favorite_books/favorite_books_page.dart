import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../config/alert_utils.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/favorite_book_dto.dart';
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
          leading: TextButton.icon(
            onPressed: () => WidgetKeys.mainNavKey.currentState!.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
            ),
            label: const Text('Back'),
            style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
          ),
          title: const Text("Favorites"),
        ),
        body: StreamBuilder<List<FavoriteBookDto>>(
          stream: GetIt.instance<FavoriteBooksBloc>().favoriteBooksStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Implement shimmer");
            }

            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) => BookListItemWidget.fromFavorites(favoriteBook: snapshot.data![index]),
                  itemCount: snapshot.data!.length,
                );
              } else {
                return const Text(AlertMessages.favoriteBooksNotFound);
              }
            }

            return const Text(AlertMessages.errorFetchingFavoriteBooks);
          },
        ),
      ),
    );
  }
}
