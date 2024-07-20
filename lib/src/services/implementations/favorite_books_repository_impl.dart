import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/dto/favorite_book_dto.dart';
import '../repositories/favorite_books_repository.dart';
import '../sqflite_client.dart';

class FavoriteBooksRepositoryImpl implements FavoriteBooksRepository {
  final _tableName = DbHelper.favoritesTable;
  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  Future<bool> addBookToFavoriteList(FavoriteBookDto instance) async {
    final db = await GetIt.instance<SqlfliteClient>().getDatabase();

    final result = await db.insert(_tableName, instance.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    _logger.i("Sqflite INSERT into => $_tableName\nResult => $result");

    return result == 0 ? false : true;
  }

  @override
  Future<List<FavoriteBookDto>> getFavoriteBooks() async {
    final db = await GetIt.instance<SqlfliteClient>().getDatabase();
    final records = await db.query(_tableName);
    _logger.i("Sqflite QUERY => $_tableName\nResult => $records");

    List<FavoriteBookDto> list = records.map((e) => FavoriteBookDto.fromMap(e)).toList();

    list.sort((a, b) => b.viewedAt.compareTo(a.viewedAt));

    return list;
  }

  @override
  Future<bool> removeFromFavorites(String isbn) async {
    final db = await GetIt.instance<SqlfliteClient>().getDatabase();
    final deletedRowCount = await db.delete(_tableName, where: 'isbn = ?', whereArgs: [isbn]);

    return deletedRowCount > 0 ? true : false;
  }
}
