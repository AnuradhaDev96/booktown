import '../../models/book.dart';

class FetchBooksState {}

class LoadingBooksState extends FetchBooksState {}

class BookListLoadedState extends FetchBooksState  {
  final List<BookDto> newBooks;

  BookListLoadedState({required this.newBooks});
}

class BookErrorState extends FetchBooksState  {
  final String message;

  BookErrorState({required this.message});
}