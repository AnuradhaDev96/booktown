import '../../models/dto/recent_search_term_dto.dart';

abstract class BookSearchHistoryRepository {
  /// Create new search term record. If a search term already exists with same search term [ConflictAlgorithm.replace]
  /// replaces the existing record. Then viewedAt time is changed
  Future<bool> addTermToRecentSearchedList(RecentSearchTermDto instance);

  /// Get recently searched terms ordered by viewed at time
  Future<List<RecentSearchTermDto>> getRecentSearches();
}
