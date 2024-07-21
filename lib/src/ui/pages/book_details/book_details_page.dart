import 'package:booktown/src/models/dto/book.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get_it/get_it.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/favorite_books_bloc.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/book_details_dto.dart';
import '../../../models/dto/favorite_book_dto.dart';
import '../../widgets/manage_favorite_books_icons.dart';

class BookDetailsPage extends StatelessWidget {
  const BookDetailsPage({super.key, required this.details});

  final BookDetailsDto details;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 20.w,
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 2.w),
          child: TextButton.icon(
            onPressed: () => WidgetKeys.mainNavKey.currentState!.pop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 16,
            ),
            label: const Text('Back'),
            style: TextButton.styleFrom(padding: EdgeInsets.zero),
          ),
        ),
        title: const Text("Book Details"),
        actions: [
          StreamBuilder<List<FavoriteBookDto>>(
            stream: GetIt.instance<FavoriteBooksBloc>().favoriteBooksStream,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final currentFavoriteList = snapshot.data!;
                if (currentFavoriteList.any((fav) => fav.isbn13 == details.isbn13)) {
                  return FavoriteIconButtonFilled(isbn: details.isbn13);
                } else {
                  return FavoriteIconButtonOutlined(
                      book: BookDto(
                    title: details.title,
                    subtitle: details.subtitle,
                    isbn13: details.isbn13,
                    price: details.price,
                    image: details.image,
                    url: details.url,
                  ));
                }
              } else {
                return IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.heart),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              width: 100.w,
              height: 30.h,
              fit: BoxFit.fitHeight,
              details.image,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(details.title),
                      Text(details.subtitle),
                    ],
                  ),
                ),
                Container(
                  width: 15.w,
                  height: 15.w,
                  padding: const EdgeInsets.all(5),
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: Center(
                    child: Text(details.price),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: AbsorbPointer(
                child: RatingBar.builder(
                  initialRating: double.tryParse(details.rating) ?? 0,
                  itemCount: 5,
                  unratedColor: Colors.grey,
                  glowColor: Colors.white,
                  itemSize: 20.sp,
                  allowHalfRating: true,
                  itemBuilder: (context, index) {
                    return const Icon(
                      Icons.star,
                      color: Colors.amber,
                    );
                  },
                  tapOnlyMode: true,
                  onRatingUpdate: (value) {},
                ),
              ),
            ),
            Text(
              details.desc,
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}
