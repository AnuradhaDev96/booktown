import '../../models/dto/book.dart';

class SearchBookResultsState {}

class LoadingSearchState extends SearchBookResultsState {}

class SearchBookResultPageState extends SearchBookResultsState {
  SearchBookResultPageState();
}

class SearchBookErrorState extends SearchBookResultsState  {
  final String message;

  SearchBookErrorState({required this.message});
}
