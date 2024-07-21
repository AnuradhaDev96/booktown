import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'app_text_styles.dart';
import 'widget_keys.dart';

abstract class AlertUtils {
  /// Show a snack-bar for general events which use global context
  static void showSnackBar(
    String message,
    AlertTypes alertType, {
    Duration duration = const Duration(milliseconds: 4000),
    ScaffoldAction? scaffoldAction,
    bool vibrate = false,
  }) {
    // WidgetKeys.mainScaffoldMessengerKey.currentState!.clearSnackBars();
    WidgetKeys.mainScaffoldMessengerKey.currentState!
      ..clearSnackBars()
      ..showSnackBar(
        SnackBar(
          padding: EdgeInsets.zero,
          content: Container(
            clipBehavior: Clip.hardEdge,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                left: BorderSide(
                  color: alertType.borderColor,
                  width: 6,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 3),
                      child: Icon(alertType.iconData, color: alertType.borderColor),
                    ),
                    Text(
                      message,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                if (scaffoldAction != null)
                  ElevatedButton(
                    onPressed: scaffoldAction.action,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.black,
                      surfaceTintColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                      textStyle: const TextStyle(
                        fontFamily: AppTextStyles.mainFontFamily,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.1,
                      ),
                    ),
                    child: Text(scaffoldAction.text),
                  ),
              ],
            ),
          ),
          duration: duration,
          behavior: SnackBarBehavior.floating,
          elevation: 8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              topRight: Radius.circular(3),
              bottomRight: Radius.circular(3),
            ),
          ),
          backgroundColor: Colors.white,
        ),
      );

    if (vibrate) {
      // Alert user with a vibration
      HapticFeedback.lightImpact();
    }
  }
}

class ScaffoldAction {
  /// function to set in button
  final Function() action;

  /// Display text of button
  final String text;

  ScaffoldAction({required this.action, required this.text});
}

enum AlertTypes {
  error(borderColor: Colors.red, title: "Error", iconData: Icons.close),
  success(borderColor: Colors.green, title: "Success", iconData: Icons.done_all),
  warning(borderColor: Colors.orange, title: "Warning", iconData: Icons.error_outline),
  info(borderColor: Colors.blue, title: "Info", iconData: Icons.info_outline);

  final Color borderColor;
  final String title;
  final IconData iconData;

  const AlertTypes({required this.borderColor, required this.title, required this.iconData});
}

/// Common messages to display in UIs, logs. Can be localized if needed.
abstract class AlertMessages {
  // Books
  static const String errorFetchingNewBooks = 'Oops! Looks like there is an error. Try refreshing the page.';
  static const String emptyNewBooks = 'Currently, there are no books listed.';

  // Search
  static const String errorFetchingSearchQuery = 'Oops! Looks like there is an error in search.';
  static const String emptySearchQuery = 'Your search does not match any books. Keep searching!';

  // Book details
  static const String errorFetchingBookDetails = 'Oops! There is an error fetching your book details.';
  static const String bookNotFound = 'Book details are not available for your selection.';

  // Favorite books
  static const String errorFetchingFavoriteBooks = 'Oops! There is an error fetching your favorite books.';
  static const String favoriteBooksNotFound = 'You don\'t have any favorite books.';
}
