import 'package:dartz/dartz.dart';

import '../../models/dto/book.dart';
import '../../models/dto/book_details_dto.dart';

abstract class BookRepository {
  /// Get new books
  Future<Either<List<BookDto>, String>> getNewBooks();

  /// Get new books
  Future<Either<BookPageResponseDto, String>> searchBooksByTitle(String query, String? page);

  /// Get book details by isbn number
  Future<Either<BookDetailsDto, String>> getBookDetailsByIsbnNo(String isbn);

  /// Get book authors by isbn number
  Future<BookAuthorDto?> getBookAuthorsIsbnNo(String isbn);
}
