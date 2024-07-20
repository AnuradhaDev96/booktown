class SearchBookResultsState {}

class InitializingSearchState extends SearchBookResultsState {}

class BookResultsLoadedState extends SearchBookResultsState {
  final String? message;

  /// Indicate whether the next page is loading for the current search term. user is further scrolling
  final bool isLoadingNextPage;

  BookResultsLoadedState({this.message, this.isLoadingNextPage = false});
}
