import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../models/view_models/search_book_result.dart';
import '../../services/repositories/book_repository.dart';
import '../states/search_book_results_state.dart';

class SearchBookResultCubit extends Cubit<SearchBookResultsState> {
  SearchBookResultCubit() : super(LoadingSearchState());
  SearchBookResult? searchResult;

  /// Search books and update the state with pagination.
  void searchBook(String query, int page) {
    GetIt.instance<BookRepository>().searchBooksByTitle(query, page.toString()).then((result) {
      result.fold(
        (pageResponse) {
          // search term is same
          if (searchResult != null && searchResult!.searchedTerm != query) {
            searchResult!.setTotal(pageResponse.total);
            searchResult!.updateCurrentTotal(pageResponse.total);
            searchResult!.searchResults.addAll(pageResponse.books);
          } else {
            searchResult = SearchBookResult(
              total: pageResponse.total,
              currentPage: pageResponse.page,
              searchResults: pageResponse.books,
              searchedTerm: query,
            );
          }
        },
        (message) => emit(SearchBookErrorState(message: message)),
      );
    });
  }
}
