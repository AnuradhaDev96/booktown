import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/dto/favorite_book_dto.dart';
import '../../services/repositories/favorite_books_repository.dart';

class FavoriteBooksBloc {
  // Favorite Books
  final _favoriteBooksSubject = BehaviorSubject<List<FavoriteBookDto>>();

  Stream<List<FavoriteBookDto>> get favoriteBooksStream => _favoriteBooksSubject.stream;

  void _syncFavoriteBookList(List<FavoriteBookDto> list) => _favoriteBooksSubject.sink.add(list);

  /// Get favorite books from local database and sync with the stream.
  Future<void> retrieveFavoriteBookList() async =>
      _syncFavoriteBookList(await GetIt.instance<FavoriteBooksRepository>().getFavoriteBooks());
}
