import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/states/search_book_results_state.dart';
import '../../../config/alert_utils.dart';
import '../../widgets/book_list_shimmer_widget.dart';
import '../../widgets/empty_list_placeholder_widget.dart';
import '../../widgets/list_seperator_widget.dart';
import 'book_list_item_widget.dart';

class BookSearchResultsWidget extends StatelessWidget {
  const BookSearchResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final searchResultCubit = BlocProvider.of<SearchBookResultCubit>(context);

    return BlocBuilder<SearchBookResultCubit, SearchBookResultsState>(
      bloc: searchResultCubit,
      builder: (BuildContext context, state) {
        if (state is InitializingSearchState) {
          return const Text("Implement shimmer");
        } else if (state is BookResultsLoadedState) {
          return PaginatedBookResultListView(currentState: state, resultCubit: searchResultCubit);
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class PaginatedBookResultListView extends StatefulWidget {
  const PaginatedBookResultListView({super.key, required this.currentState, required this.resultCubit});

  final BookResultsLoadedState currentState;
  final SearchBookResultCubit resultCubit;

  @override
  State<PaginatedBookResultListView> createState() => _PaginatedBookResultListViewState();
}

class _PaginatedBookResultListViewState extends State<PaginatedBookResultListView> {
  final ScrollController _scrollController = ScrollController();

  bool onNotificationCallback(ScrollNotification notification) {
    if (notification is ScrollEndNotification && notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      // User has reached the end of the list. Load more data
      BlocProvider.of<SearchBookResultCubit>(context).loadNextPageWithCurrentSearchTerm();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: onNotificationCallback,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          (widget.resultCubit.loadedBooks != null && widget.resultCubit.loadedBooks!.searchResults.isNotEmpty)
              ? SliverToBoxAdapter(
                  child: NotificationListener<ScrollNotification>(
                    onNotification: onNotificationCallback,
                    child: ListView.separated(
                      padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 3.w, right: 3.w),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemBuilder: (context, index) => BookListItemWidget(
                        bookDto: widget.resultCubit.loadedBooks!.searchResults[index],
                      ),
                      itemCount: widget.resultCubit.loadedBooks!.searchResults.length,
                      separatorBuilder: (context, index) => const ListSeparatorWidget(),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h),
                    child: const EmptyListPlaceholderWidget(message: AlertMessages.emptySearchQuery),
                  ),
                ),
          if (widget.currentState.isLoadingNextPage)
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(bottom: 4.h, left: 3.w, right: 3.w),
                child: const BookListItemShimmer(),
              ),
            ),
          if (widget.currentState.message != null && widget.currentState.message!.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Center(
                  child: Text(widget.currentState.message!),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
