class BookDto {
  final String title, subtitle, isbn13, price, image, url;

  BookDto({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
  });

  BookDto.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        subtitle = map['subtitle'] ?? '',
        isbn13 = map['isbn13'] ?? '',
        price = map['price'] ?? '',
        image = map['image'] ?? '',
        url = map['url'] ?? '';
}

class BookPageResponseDto {
  final int total, page;
  final List<BookDto> books;

  BookPageResponseDto.fromMap(Map<String, dynamic> map)
      : total = map['total'] != null ? int.parse(map['total']) : 0,
        page = map['page'] != null ? int.parse(map['page']) : 0,
        books = map['books'] != null
            ? (map["books"] as List<dynamic>).map((i) => BookDto.fromMap(i)).toList()
            : <BookDto>[];
}
