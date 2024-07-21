import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/cubits/switch_list_mode_cubit.dart';
import '../../../config/widget_keys.dart';
import '../../../models/dto/recent_search_term_dto.dart';
import '../../../services/repositories/book_search_history_repository.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({super.key, required this.heartIconRectKey, this.onHeartButtonPressed});

  final GlobalKey<RectGetterState> heartIconRectKey;

  /// Pass function as parameter
  final Function()? onHeartButtonPressed;

  /// This controller is used for ValueListenableBuilder to listen changes in text
  final TextEditingController _searchTermController = TextEditingController();

  final SearchController _searchController = SearchController();

  final ValueNotifier<List<RecentSearchTermDto>> _recentSearchedTerms =
      ValueNotifier<List<RecentSearchTermDto>>(<RecentSearchTermDto>[]);

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
            child: ValueListenableBuilder(
                valueListenable: _recentSearchedTerms,
                builder: (context, searchHistoryList, _) {
                  return SearchAnchor(
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
                            autofocus: false,
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
                                    // Get recent search history and update UI list.
                                    GetIt.instance<BookSearchHistoryRepository>()
                                        .getRecentSearches()
                                        .then((searchHistory) {
                                      _recentSearchedTerms.value = searchHistory;

                                      if (searchHistory.isNotEmpty) {
                                        anchorController.openView();
                                      }
                                    });
                                  }
                                },
                              ),
                              suffixIcon: searchTerm.text.isNotEmpty
                                  ? IconButton(
                                      onPressed: () {
                                        _searchTermController.clear();
                                        // BlocProvider.of<SwitchBookListModeCubit>(context).switchToListMode();
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
                      return _recentSearchedTerms.value
                          .map(
                            (recentSearchItem) => ListTile(
                              title: Text(recentSearchItem.searchTerm),
                              onTap: () {
                                FocusScope.of(context).unfocus();
                                anchorController.closeView(null);
                                _searchBookByTitle(recentSearchItem.searchTerm, context);
                              },
                            ),
                          )
                          .toList();
                    },
                  );
                }),
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
