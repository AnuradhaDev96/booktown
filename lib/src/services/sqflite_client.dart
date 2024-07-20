import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DbHelper {
  static const dbVersion = 1;
  static const dbName = 'booktown_cache.db';
  static const favoritesTable = 'Favorites';
  static const recentSearchTerms = 'RecentSearchTerms';

  static const createFavoritesTableCommand =
      'CREATE TABLE $favoritesTable(variantId TEXT PRIMARY KEY, productId TEXT, name TEXT, image TEXT, viewedAt TEXT,price TEXT)';

  static const recentSearchTermsTableCommand = 'CREATE TABLE $recentSearchTerms(searchTerm TEXT PRIMARY KEY, viewedAt TEXT)';
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
          await db.execute(DbHelper.favoritesTable);
          await db.execute(DbHelper.recentSearchTermsTableCommand);
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
