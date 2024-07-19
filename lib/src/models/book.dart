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
