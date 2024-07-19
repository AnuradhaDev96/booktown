import 'package:dartz/dartz.dart';
import 'package:get_it/get_it.dart';

import '../../config/alert_utils.dart';
import '../../models/book.dart';
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
}
