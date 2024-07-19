class BookDto {
  final String title, subtitle, isbn13, price, image, url;

  BookDto.fromMap(Map<String, dynamic> map)
      : title = map['title'],
        subtitle = map['subtitle'],
        isbn13 = map['isbn13'],
        price = map['price'],
        image = map['image'],
        url = map['url'];
}

class BookPageResponseDto {
  final int total, page;
  final List<BookDto> books;

  BookPageResponseDto.fromMap(Map<String, dynamic> map)
      : total = int.parse(map['total']),
        page = int.parse(map['page']),
        books = map['books'] != null
            ? (map["books"] as List<dynamic>).map((i) => BookDto.fromMap(i)).toList()
            : <BookDto>[];
}
