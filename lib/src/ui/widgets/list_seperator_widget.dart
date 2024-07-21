import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ListSeparatorWidget extends StatelessWidget {
  const ListSeparatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 5.h,
      indent: 5.w,
      endIndent: 5.w,
      thickness: 2.5,
    );
  }
}
