import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer/shimmer.dart';

class BookListItemShimmer extends StatelessWidget {
  const BookListItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Color highlightColor = (Theme.of(context).brightness == Brightness.dark) ? Colors.grey[700]! : Colors.white60;
    final Color baseColor = (Theme.of(context).brightness == Brightness.dark) ? Colors.grey[900]! : const Color(0xFFCDCDCD);
    return Shimmer.fromColors(
      highlightColor: highlightColor,
      baseColor: baseColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20.w,
            height: 20.w,
            margin: EdgeInsets.only(right: 2.w),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 20,
                  margin: const EdgeInsets.only(bottom: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.5),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 8,
                  width: 75.w,
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.5),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  height: 8,
                  width: 40.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.5),
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CupertinoIcons.heart_fill),
          )
        ],
      ),
    );
  }
}

class ShimmerListWidget extends StatelessWidget {
  const ShimmerListWidget({super.key, required this.itemCount, required this.padding});

  final int itemCount;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: itemCount,
      itemBuilder: (context, index) => const BookListItemShimmer(),
      separatorBuilder: (context, index) => SizedBox(height: 5.5.h)
    );
  }
}
