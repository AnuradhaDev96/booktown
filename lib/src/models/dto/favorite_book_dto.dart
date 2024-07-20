class FavoriteBookDto {
  final String title, subtitle, isbn13, price, image, url;

  /// Can be used to sort by viewed time
  final DateTime viewedAt;

  FavoriteBookDto({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
    required this.viewedAt,
  });

  FavoriteBookDto.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        subtitle = map['subtitle'] ?? '',
        isbn13 = map['isbn13'] ?? '',
        price = map['price'] ?? '',
        image = map['image'] ?? '',
        url = map['url'] ?? '',
        viewedAt = DateTime.parse(map['viewedAt']);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'isbn13': isbn13,
      'price': price,
      'image': image,
      'url': url,
      'viewedAt': viewedAt.toIso8601String(),
    };
  }
}
