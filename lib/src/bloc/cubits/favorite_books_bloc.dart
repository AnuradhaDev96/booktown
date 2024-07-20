import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';

import '../../models/dto/book.dart';
import '../../models/dto/favorite_book_dto.dart';
import '../../services/repositories/favorite_books_repository.dart';
import '../states/data_payload_state.dart';

class FavoriteBooksBloc {
  // Favorite Books
  final _favoriteBooksSubject = BehaviorSubject<List<FavoriteBookDto>>();

  Stream<List<FavoriteBookDto>> get favoriteBooksStream => _favoriteBooksSubject.stream;

  List<FavoriteBookDto> get favoriteBooksValue => _favoriteBooksSubject.value;

  void _syncFavoriteBookList(List<FavoriteBookDto> list) => _favoriteBooksSubject.sink.add(list);

  /// Get favorite books from local database and sync with the stream.
  Future<void> retrieveFavoriteBookList() async =>
      _syncFavoriteBookList(await GetIt.instance<FavoriteBooksRepository>().getFavoriteBooks());
}

class RemoveFavoriteBookCubit extends Cubit<DataPayloadState> {
  RemoveFavoriteBookCubit() : super(InitialState());

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

class AddFavoriteBookCubit extends Cubit<DataPayloadState> {
  AddFavoriteBookCubit() : super(InitialState());

  Future<void> addToFavorites({required BookDto serverBook}) async {
    emit(RequestingState());

    final bool result = await GetIt.instance<FavoriteBooksRepository>().addBookToFavoriteList(FavoriteBookDto(
      title: serverBook.title,
      subtitle: serverBook.subtitle,
      isbn13: serverBook.isbn13,
      price: serverBook.price,
      image: serverBook.image,
      url: serverBook.url,
      viewedAt: DateTime.now(),
    ));

    if (result) {
      GetIt.instance<FavoriteBooksBloc>().retrieveFavoriteBookList();
      emit(SuccessState());
    } else {
      emit(ErrorState("This book can't be marked as favorite"));
    }
  }
}
