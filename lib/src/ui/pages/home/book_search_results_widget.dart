import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubits/search_book_result_cubit.dart';
import '../../../bloc/states/search_book_results_state.dart';

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
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels == notification.metrics.maxScrollExtent) {
      // User has reached the end of the list. Load more data
      BlocProvider.of<SearchBookResultCubit>(context).loadNextPageWithCurrentSearchTerm();
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        (widget.resultCubit.loadedBooks != null && widget.resultCubit.loadedBooks!.searchResults.isNotEmpty)
            ? SliverToBoxAdapter(
          child: NotificationListener<ScrollNotification>(
            onNotification: onNotificationCallback,
            child: ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemBuilder: (context, index) => SizedBox(
                height: 140,
                child: Text("$index\n${widget.resultCubit.loadedBooks!.searchResults[index].title}"),
              ),
              itemCount: widget.resultCubit.loadedBooks!.searchResults.length,
            ),
          ),
        )
            : const Text("Search results empty"),
        if (widget.currentState.isLoadingNextPage)
          const SliverToBoxAdapter(
            child: Text("Next page item shimmer"),
          ),
        if (widget.currentState.message != null && widget.currentState.message!.isNotEmpty)
          SliverToBoxAdapter(
            child: Text(widget.currentState.message!),
          ),
      ],
    );
  }
}
