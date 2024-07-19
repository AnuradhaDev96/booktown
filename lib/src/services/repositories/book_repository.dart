import 'package:dartz/dartz.dart';

import '../../models/dto/book.dart';

abstract class BookRepository {
  /// Get new books
  Future<Either<List<BookDto>, String>> getNewBooks();

  /// Get new books
  Future<Either<BookPageResponseDto, String>> searchBooksByTitle(String query, String? page);
}
