import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import '../../config/alert_utils.dart';
import '../../models/dto/book.dart';
import '../../models/dto/book_details_dto.dart';
import '../dio_client.dart';
import '../repositories/book_repository.dart';

class BookRepositoryImpl implements BookRepository {
  @override
  Future<Either<List<BookDto>, String>> getNewBooks() async {
    try {
      var response = await GetIt.instance<DioClient>().dio.get('new');

      final List<BookDto> bookList = (response.data["books"] as List<dynamic>).map((i) => BookDto.fromMap(i)).toList();

      return bookList.isNotEmpty ? left(bookList) : right(AlertMessages.emptyNewBooks);
    } catch (e) {
      return right(AlertMessages.errorFetchingNewBooks);
    }
  }

  @override
  Future<Either<BookPageResponseDto, String>> searchBooksByTitle(String query, String? page) async {
    try {
      String encodedString = Uri.encodeQueryComponent(query);
      var response = await GetIt.instance<DioClient>().dio.get(
            'search/$encodedString',
            queryParameters: page == null ? null : {'page': page},
          );

      final BookPageResponseDto pageResponse = BookPageResponseDto.fromMap(response.data);

      return left(pageResponse);
    } catch (e) {
      return right(AlertMessages.errorFetchingNewBooks);
    }
  }

  @override
  Future<Either<BookDetailsDto, String>> getBookDetailsByIsbnNo(String isbn) async {
    try {
      var response = await GetIt.instance<DioClient>().dio.get('books/$isbn');

      final BookDetailsDto detailsDto = BookDetailsDto.fromMap(response.data);

      if (detailsDto.error != "0") {
        return right(AlertMessages.bookNotFound);
      } else {
        return left(detailsDto);
      }
    } catch (e) {
      return right(AlertMessages.errorFetchingNewBooks);
    }
  }
}
