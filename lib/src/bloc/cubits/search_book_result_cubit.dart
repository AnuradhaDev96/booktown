import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../models/view_models/search_book_result.dart';
import '../../services/repositories/book_repository.dart';
import '../states/search_book_results_state.dart';

class SearchBookResultCubit extends Cubit<SearchBookResultsState> {
  SearchBookResultCubit() : super(InitializingSearchState());
  SearchBookResult? loadedBooks;

  /// Search books and update the state with pagination.
  void searchBook(String searchTerm) {
    // Fetch if there is any records left to retrieve by comparing the total record count for the same query
    if (loadedBooks?.searchedTerm == searchTerm && loadedBooks?.searchResults.length != loadedBooks?.total) {
      GetIt.instance<BookRepository>()
          .searchBooksByTitle(searchTerm, loadedBooks != null ? (loadedBooks!.currentPage + 1).toString() : null)
          .then((result) {
        result.fold(
          (pageResponse) {
            if (loadedBooks != null && loadedBooks!.searchedTerm != searchTerm) {
              // search term is same. hence update the values with new page
              loadedBooks!.setTotal(pageResponse.total);
              loadedBooks!.updateCurrentTotal(pageResponse.total);
              loadedBooks!.searchResults.addAll(pageResponse.books);
            } else {
              // instantiate new result with initial results.
              loadedBooks = SearchBookResult(
                total: pageResponse.total,
                currentPage: pageResponse.page,
                searchResults: pageResponse.books,
                searchedTerm: searchTerm,
              );
            }

            emit(BookResultsLoadedState());
          },
          (message) => emit(BookResultsLoadedState(message: message)),
        );
      });
    }
  }

  /// Do a refresh to get search results.
  void refreshSearch(String query) {
    emit(InitializingSearchState());

    GetIt.instance<BookRepository>().searchBooksByTitle(query, null).then((result) {
      result.fold(
        (pageResponse) {
          loadedBooks = SearchBookResult(
            total: pageResponse.total,
            currentPage: pageResponse.page,
            searchResults: pageResponse.books,
            searchedTerm: query,
          );

          emit(BookResultsLoadedState());
        },
        (message) => emit(BookResultsLoadedState(message: message)),
      );
    });
  }
}
