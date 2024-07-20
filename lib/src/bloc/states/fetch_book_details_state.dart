import '../../models/dto/book_details_dto.dart';

class BookDetailsState {}

class BookDetailsIdleState extends BookDetailsState {}

class FetchingBookDetailsState extends BookDetailsState {}

class BookDetailsSuccessState extends BookDetailsState {
  final BookDetailsDto detailsDto;

  BookDetailsSuccessState({required this.detailsDto});
}

class BookDetailsErrorState extends BookDetailsState {
  final String errorMessage;

  BookDetailsErrorState({required this.errorMessage});
}
