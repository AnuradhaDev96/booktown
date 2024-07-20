class BookDetailsDto {
  final String title, subtitle, isbn13, price, image, desc;

  BookDetailsDto.fromMap(Map<String, dynamic> map)
      : title = map['title'] ?? '',
        subtitle = map['subtitle'] ?? '',
        isbn13 = map['isbn13'] ?? '',
        price = map['price'] ?? '',
        image = map['image'] ?? '',
        desc = map['desc'] ?? '';
}

var x = {
  "error": "0",
  "title": "Securing DevOps",
  "subtitle": "Security in the Cloud",
  "authors": "Julien Vehent",
  "publisher": "Manning",
  "language": "English",
  "isbn10": "1617294136",
  "isbn13": "9781617294136",
  "pages": "384",
  "year": "2018",
  "rating": "4",
  "desc": "An application running in the cloud can benefit from incredible efficiencies, but they come with unique security threats too. A DevOps team&#039;s highest priority is understanding those risks and hardening the system against them.Securing DevOps teaches you the essential techniques to secure your c...",
  "price": "\$39.65",
  "image": "https://itbook.store/img/books/9781617294136.png",
  "url": "https://itbook.store/books/9781617294136",
  "pdf": {
    "Chapter 2": "https://itbook.store/files/9781617294136/chapter2.pdf",
    "Chapter 5": "https://itbook.store/files/9781617294136/chapter5.pdf"
  }
};