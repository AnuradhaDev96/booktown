import '../../models/dto/favorite_book_dto.dart';

abstract class FavoriteBooksRepository {
  /// Create new favorite book record. If a book already exists with same isbn no [ConflictAlgorithm.replace]
  /// replaces the existing record. Then viewedAt time is changed.
  Future<bool> addBookToFavoriteList(FavoriteBookDto instance);

  /// Get recently saved books ordered(sorted) by viewed at time
  Future<List<FavoriteBookDto>> getFavoriteBooks();
}
