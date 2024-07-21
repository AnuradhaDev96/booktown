import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../bloc/cubits/fetch_books_cubit.dart';
import '../../../bloc/states/fetch_books_state.dart';
import '../../../models/dto/book.dart';
import '../../widgets/book_list_shimmer_widget.dart';
import '../../widgets/empty_list_placeholder_widget.dart';
import '../../widgets/list_seperator_widget.dart';
import 'book_list_item_widget.dart';

class BookListWidget extends StatelessWidget {
  BookListWidget({super.key});

  final _fetchBooksCubit = FetchBooksCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FetchBooksCubit>(
      create: (context) => _fetchBooksCubit..fetchNewBooks(),
      child: BlocBuilder<FetchBooksCubit, FetchBooksState>(
        builder: (BuildContext context, state) {
          if (state is LoadingBooksState) {
            return ShimmerListWidget(
              padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 3.w, right: 3.w),
              itemCount: 10,
            );
          } else if (state is BookListLoadedState) {
            return PaginatedBookListView(newBooks: state.newBooks);
          } else if (state is BookErrorState) {
            return EmptyListPlaceholderWidget(message: state.message);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class PaginatedBookListView extends StatefulWidget {
  const PaginatedBookListView({super.key, required this.newBooks});

  final List<BookDto> newBooks;

  @override
  State<PaginatedBookListView> createState() => _PaginatedBookListViewState();
}

class _PaginatedBookListViewState extends State<PaginatedBookListView> {
  final ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  final int _pageSize = 8;

  final List<BookDto> _paginatedList = <BookDto>[];

  void _loadNextPage() {
    final int startIndex = _currentPage * _pageSize;
    final int endIndex = startIndex + _pageSize;

    if (startIndex < widget.newBooks.length) {
      setState(() {
        _paginatedList.addAll(widget.newBooks.sublist(
          startIndex,
          endIndex > widget.newBooks.length ? widget.newBooks.length : endIndex,
        ));
        _currentPage++;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async =>  BlocProvider.of<FetchBooksCubit>(context).fetchNewBooks(),
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollEndNotification &&
              notification.metrics.pixels == notification.metrics.maxScrollExtent) {
            // User has reached the end of the list. Load more data
            _loadNextPage();
          }
          return false;
        },
        child: ListView.separated(
          padding: EdgeInsets.only(top: 4.h, bottom: 8.h, left: 3.w, right: 3.w),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          itemBuilder: (context, index) => BookListItemWidget(bookDto: _paginatedList[index]),
          itemCount: _paginatedList.length,
          separatorBuilder: (context, index) => const ListSeparatorWidget(),
        ),
      ),
    );
  }
}
