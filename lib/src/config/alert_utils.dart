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
                      child: Icon(alertType.iconData, color: Colors.green),
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
  // Banners
  static const String errorFetchingBanners = 'Error fetching banners';
  static const String errorFetchingCategoriesWithChildren = 'Error fetching categories';

  // Categories & Collections
  static const String emptyCategoriesWithChildren = 'No categories available';
  static const String emptyCollectionsWithChildren = 'No collections available';
  static const String emptyTrousersWithChildren = 'No trouser collections available';
  static const String emptyTShirtsWithChildren = 'No t-shirt collections available';
  static const String emptyShirtsWithChildren = 'No shirt collections available';
  static const String emptyJeansWithChildren = 'No jeans collections available';

  // Products
  static const String errorFetchingProducts = 'Error fetching products';
  static const String emptyProducts = 'No products available';
  static const String notifyMe = 'We will notify you once the item is back in stock.';
  static const String errorFetchingProductReviews = 'Error fetching products reviews';
  static const String emptyOrders = 'No orders available';
  static const String emptyFilters = 'No filters available';

  // Order
  static const String emptyOrder = 'No order available';
  static const String errorFetchingOrder = 'Order not found. Please ensure the order code is correct and try again';
  static const String errorFetchingOrders = 'Error fetching your order history';
  static const String errorFetchingDiscounts = 'Error fetching discounts';
  static const String errorFetchingStores = 'Error fetching stores';

  // Cart
  static const String errorFetchingCustomerCart = 'Error fetching customer\'s cart';
  static const String couponApplied = 'Coupon successfully applied';
  static const String couponNotFound = "Coupon couldn't be applied";

  // Validations
  static const String phoneNumberIsRequired = 'Phone number is required';

  // Policy
  static const String errorFetchingPolicy = 'Error fetching policy details';

  // Shipping
  static const String shippingFeeError = "Error fetching shipping fee";

  // Trending Now Categories
  static const String errorFetchingTrendingNowCategory = "Error fetching trending categories";
}
