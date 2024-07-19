import '../dto/book.dart';

class SearchBookResult {
  int total, currentPage;
  final List<BookDto> searchResults;
  final String searchedTerm;

  SearchBookResult({
    required this.total,
    required this.currentPage,
    required this.searchResults,
    required this.searchedTerm,
  });

  void setTotal(int newTotal) {
    total = newTotal;
  }

  void updateCurrentTotal(int newPage) {
    currentPage = newPage;
  }
}
