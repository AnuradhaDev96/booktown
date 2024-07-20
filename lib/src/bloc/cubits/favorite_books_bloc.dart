import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/dto/favorite_book_dto.dart';
import '../../services/repositories/favorite_books_repository.dart';
import '../states/data_payload_state.dart';

class FavoriteBooksBloc {
  // Favorite Books
  final _favoriteBooksSubject = BehaviorSubject<List<FavoriteBookDto>>();

  Stream<List<FavoriteBookDto>> get favoriteBooksStream => _favoriteBooksSubject.stream;

  void _syncFavoriteBookList(List<FavoriteBookDto> list) => _favoriteBooksSubject.sink.add(list);

  /// Get favorite books from local database and sync with the stream.
  Future<void> retrieveFavoriteBookList() async =>
      _syncFavoriteBookList(await GetIt.instance<FavoriteBooksRepository>().getFavoriteBooks());
}


class DeleteFavoriteBookCubit extends Cubit<DataPayloadState> {
  DeleteFavoriteBookCubit() : super(InitialState());

  Future<void> removeBookFromFavorites(String isbn) async {
    emit(RequestingState());

    final bool result = await GetIt.instance<FavoriteBooksRepository>().removeFromFavorites(isbn);

    if (result) {
      GetIt.instance<FavoriteBooksBloc>().retrieveFavoriteBookList();
      emit(SuccessState());
    } else {
      emit(ErrorState("This book can't be removed from favorites"));
    }
  }
}
