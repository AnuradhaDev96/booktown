class RecentSearchTermDto {
  final String searchTerm;
  final DateTime viewedAt;

  RecentSearchTermDto({required this.searchTerm, required this.viewedAt});

  RecentSearchTermDto.fromMap(Map<String, dynamic> map)
      : searchTerm = map['searchTerm'],
        viewedAt = DateTime.parse(map['viewedAt']);

  Map<String, dynamic> toMap() {
    return {
      'searchTerm': searchTerm,
      'viewedAt': viewedAt.toIso8601String(),
    };
  }
}
