import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../config/app_routes.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/book.dart';

class BookListItemWidget extends StatelessWidget {
  const BookListItemWidget({super.key, required this.bookDto});

  final BookDto bookDto;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        context.loaderOverlay.show();
        // WidgetKeys.mainNavKey.currentState!.pushNamed(RouteNames.bookDetailsPage);
        context.loaderOverlay.hide();
      },
      child: SizedBox(height: 140, child: Text(bookDto.title)),
    );
  }
}
