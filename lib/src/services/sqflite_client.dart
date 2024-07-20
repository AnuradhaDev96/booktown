import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbHelper {
  static const dbVersion = 1;
  static const dbName = 'booktown_cache.db';
  static const favoritesTable = 'Favorites';
  static const recentSearchTerms = 'RecentSearchTerms';

  static const createFavoritesTableCommand =
      'CREATE TABLE $favoritesTable(isbn13 TEXT PRIMARY KEY, title TEXT, subtitle TEXT, price TEXT, image TEXT, url TEXT, viewedAt TEXT)';

  static const createRecentSearchTermsTableCommand =
      'CREATE TABLE $recentSearchTerms(searchTerm TEXT PRIMARY KEY, viewedAt TEXT)';
}

class SqlfliteClient {
  SqlfliteClient() {
    initDatabase();
  }

  Future<void> initDatabase() async {
    try {
      await openDatabase(
        join(await getDatabasesPath(), DbHelper.dbName),
        onCreate: (db, version) async {
          await db.execute(DbHelper.createFavoritesTableCommand);
          await db.execute(DbHelper.createRecentSearchTermsTableCommand);
        },
        version: DbHelper.dbVersion,
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  Future<Database> getDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), DbHelper.dbName),
      version: DbHelper.dbVersion,
    );
  }
}
