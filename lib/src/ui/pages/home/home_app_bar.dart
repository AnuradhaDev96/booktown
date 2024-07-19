import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../config/app_styles.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {},
          ),

          // Update suffix icon based on text input
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: _searchController,
              builder: (context, searchTerm, _) {
                return TextFormField(
                  controller: _searchController,
                  autofocus: true,
                  textInputAction: TextInputAction.search,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  onFieldSubmitted: (value) {
                    if (_searchController.text.isNotEmpty) {
                      // Search books
                    }
                  },
                  keyboardType: TextInputType.text,
                  decoration: AppStyles.commonInputDecoration(
                    hintText: 'Search',
                    contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                    suffixIcon: searchTerm.text.isNotEmpty
                        ? IconButton(
                            onPressed: () => _searchController.clear(),
                            icon: const Icon(Icons.close),
                          )
                        : null,
                  ),
                  cursorColor: Colors.black,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '';
                    }

                    return null;
                  },
                );
              },
            ),
          ),

          IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.heart_fill))
        ],
      ),
    );
  }
}
