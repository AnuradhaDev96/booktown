import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../services/repositories/book_repository.dart';
import '../states/fetch_book_details_state.dart';

class FetchBookDetailsCubit extends Cubit<BookDetailsState> {
  FetchBookDetailsCubit() : super(BookDetailsIdleState());

  void fetchBookDetails(String isbn) {
    emit(FetchingBookDetailsState());

    GetIt.instance<BookRepository>().getBookDetailsByIsbnNo(isbn).then((result) {
      result.fold(
        (details) => emit(BookDetailsSuccessState(detailsDto: details)),
        (message) => emit(BookDetailsErrorState(errorMessage: message)),
      );
    });
  }
}
