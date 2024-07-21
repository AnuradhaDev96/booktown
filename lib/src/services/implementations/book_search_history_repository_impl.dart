import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../../models/dto/recent_search_term_dto.dart';
import '../repositories/book_search_history_repository.dart';
import '../sqflite_client.dart';

class BookSearchHistoryRepositoryImpl implements BookSearchHistoryRepository {
  final _tableName = DbHelper.recentSearchTerms;
  final _logger = Logger(printer: PrettyPrinter(methodCount: 0));

  @override
  Future<bool> addTermToRecentSearchedList(RecentSearchTermDto instance) async {
    final db = await GetIt.instance<SqlfliteClient>().getDatabase();

    final result = await db.insert(_tableName, instance.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);

    _logger.i("Sqflite INSERT into => $_tableName\nResult => $result");

    return result == 0 ? false : true;
  }

  @override
  Future<List<RecentSearchTermDto>> getRecentSearches() async {
    final db = await GetIt.instance<SqlfliteClient>().getDatabase();
    final records = await db.query(_tableName);
    _logger.i("Sqflite QUERY => $_tableName\nResult => $records");

    List<RecentSearchTermDto> list = records.map((e) => RecentSearchTermDto.fromMap(e)).toList();

    list.sort((a, b) => b.viewedAt.compareTo(a.viewedAt));

    return list;
  }
}
