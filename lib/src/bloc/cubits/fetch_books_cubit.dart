import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../services/repositories/book_repository.dart';
import '../states/fetch_books_state.dart';

class FetchBooksCubit extends Cubit<FetchBooksState> {
  FetchBooksCubit() : super(LoadingBooksState());

  void fetchNewBooks() {
    emit(LoadingBooksState());
    GetIt.instance<BookRepository>().getNewBooks().then((result) {
      result.fold(
        (list) => emit(BookListLoadedState(newBooks: list)),
        (message) => emit(BookErrorState(message: message)),
      );
    });
  }
}
