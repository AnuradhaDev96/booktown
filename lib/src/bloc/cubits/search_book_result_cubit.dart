import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../services/repositories/book_repository.dart';
import '../states/search_book_results_state.dart';

class SearchBookResultCubit extends Cubit<SearchBookResultsState> {
  SearchBookResultCubit() : super(LoadingSearchState());

  void searchBook(String query, int page) {
    GetIt.instance<BookRepository>().searchBooksByTitle(query, page.toString()).then((result) {
      result.fold(
            (newPage) {

            },
            (message) => emit(SearchBookErrorState(message: message)),
      );
    });
  }
}
