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
    if (loadedBooks != null &&
        loadedBooks!.searchedTerm == searchTerm &&
        loadedBooks?.searchResults.length != loadedBooks?.total) {
      var currentState = state;
      if (currentState is BookResultsLoadedState) {
        // call API call if next page loading state is false
        if (!currentState.isLoadingNextPage) {
          _getNextPage(searchTerm);
        }
      } else {
        // API call can be triggered for next page
        _getNextPage(searchTerm);
      }
    } else {
      newSearch(searchTerm);
    }
  }

  /// Do a refresh to get search results.
  void newSearch(String searchTerm) {
    emit(InitializingSearchState());

    GetIt.instance<BookRepository>().searchBooksByTitle(searchTerm, null).then((result) {
      result.fold(
        (pageResponse) {
          loadedBooks = SearchBookResult(
            total: pageResponse.total,
            currentPage: pageResponse.page,
            searchResults: pageResponse.books,
            searchedTerm: searchTerm,
          );

          emit(BookResultsLoadedState());
        },
        (message) => emit(BookResultsLoadedState(message: message)),
      );
    });
  }

  /// get next page of current search term
  void _getNextPage(String searchTerm) {
    emit(BookResultsLoadedState(isLoadingNextPage: true));
    GetIt.instance<BookRepository>()
        .searchBooksByTitle(searchTerm, (loadedBooks!.currentPage + 1).toString())
        .then((result) {
      result.fold(
        (pageResponse) {
          loadedBooks!.setTotal(pageResponse.total);
          loadedBooks!.updateCurrentPage(pageResponse.page);
          loadedBooks!.searchResults.addAll(pageResponse.books);

          emit(BookResultsLoadedState());
        },
        (message) => emit(BookResultsLoadedState(message: message)),
      );
    });
  }

  /// public method to load next page
  void loadNextPageWithCurrentSearchTerm() {
    if (loadedBooks != null) {
      searchBook(loadedBooks!.searchedTerm);
    }
  }
}
