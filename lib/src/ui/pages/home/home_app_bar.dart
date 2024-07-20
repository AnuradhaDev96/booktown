import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/cubits/switch_list_mode_cubit.dart';
import '../../../config/app_routes.dart';
import '../../../config/app_styles.dart';
import '../../../config/widget_keys.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key});

  /// This controller is used for ValueListenableBuilder to listen changes in text
  final TextEditingController _searchTermController = TextEditingController();

  final List<String> recentSearch = <String>['mongodb', 'mern'];
  final SearchController _searchController = SearchController();

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
            child: SearchAnchor(
              isFullScreen: false,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.search,
              searchController: _searchController,
              viewHintText: 'Search books by title',
              viewOnSubmitted: (value) => _searchBookByTitle(value, context),
              builder: (context, anchorController) {
                return ValueListenableBuilder(
                  valueListenable: _searchTermController,
                  builder: (context, searchTerm, _) {
                    return TextFormField(
                      controller: _searchTermController,
                      textInputAction: TextInputAction.search,
                      onTapOutside: (event) => FocusScope.of(context).unfocus(),
                      onFieldSubmitted: (value) => _searchBookByTitle(value, context),
                      keyboardType: TextInputType.text,
                      decoration: AppStyles.commonInputDecoration(
                        hintText: 'Search',
                        contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                        prefixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () {
                            if (_searchTermController.text.isNotEmpty) {
                              _searchBookByTitle(_searchTermController.text, context);
                            } else {
                              anchorController.openView();
                            }
                          },
                        ),
                        suffixIcon: searchTerm.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {
                                  _searchTermController.clear();
                                  BlocProvider.of<SwitchBookListModeCubit>(context).switchToListMode();
                                },
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
                );
              },
              suggestionsBuilder: (suggestContext, anchorController) {
                return recentSearch
                    .map(
                      (recentSearchItem) => ListTile(
                        title: Text(recentSearchItem),
                        onTap: () {
                          anchorController.closeView(recentSearchItem);
                          _searchBookByTitle(recentSearchItem, context);
                        },
                      ),
                    )
                    .toList();
              },
            ),
          ),

          IconButton(
            onPressed: () => WidgetKeys.mainNavKey.currentState!.pushNamed(RouteNames.favoriteBooksPage),
            icon: const Icon(CupertinoIcons.heart_fill),
          ),
        ],
      ),
    );
  }

  void _searchBookByTitle(String searchTerm, BuildContext context) {
    if (searchTerm.isNotEmpty) {
      // Search books
      BlocProvider.of<SearchBookResultCubit>(context).searchBook(searchTerm);

      // Switch to search mode
      BlocProvider.of<SwitchBookListModeCubit>(context).switchToSearchMode();
    }
  }
}
