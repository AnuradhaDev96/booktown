class SearchBookResultsState {}

class InitializingSearchState extends SearchBookResultsState {}

class BookResultsLoadedState extends SearchBookResultsState {
  final String? message;
  final bool isLoadingNextPage;
  BookResultsLoadedState({this.message, this.isLoadingNextPage = false});
}
