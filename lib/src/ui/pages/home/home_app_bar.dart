import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/cubits/switch_list_mode_cubit.dart';
import '../../../config/widget_keys.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key, required this.heartIconRectKey, this.onHeartButtonPressed});
  final GlobalKey<RectGetterState> heartIconRectKey;

  /// Pass function as parameter
  final Function()? onHeartButtonPressed;

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
            onPressed: () {
              WidgetKeys.homePageKey.currentState!.openDrawer();
            },
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
                      decoration: InputDecoration(
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
                          FocusScope.of(context).unfocus();
                          anchorController.closeView(recentSearchItem);
                          _searchBookByTitle(recentSearchItem, context);
                        },
                      ),
                    )
                    .toList();
              },
            ),
          ),

          RectGetter(
            key: heartIconRectKey,
            child: IconButton(
              onPressed: onHeartButtonPressed,
              icon: const Icon(CupertinoIcons.heart_fill),
            ),
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
