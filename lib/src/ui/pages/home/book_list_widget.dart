import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubits/fetch_books_cubit.dart';
import '../../../bloc/states/fetch_books_state.dart';
import '../../../models/book.dart';

class BookListWidget extends StatelessWidget {
  BookListWidget({super.key});

  final _fetchBooksCubit = FetchBooksCubit();

  @override
  Widget build(BuildContext context) {
    _fetchBooksCubit.fetchNewBooks();
    return MultiBlocProvider(
      providers: [
        BlocProvider<FetchBooksCubit>(
          create: (context) => _fetchBooksCubit,
        ),
      ],
      child: BlocBuilder<FetchBooksCubit, FetchBooksState>(
        bloc: _fetchBooksCubit,
        builder: (BuildContext context, state) {
          if (state is LoadingBooksState) {
            return const Text("Implement shimmer");
          } else if (state is BookListLoadedState) {
            return PaginatedBookListView(newBooks: state.newBooks);
          } else if (state is BookErrorState) {
            return Text(state.message);
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
  final int _pageSize = 6;

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
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          // User has reached the end of the list. Load more data
          _loadNextPage();
        }
        return false;
      },
      child: ListView.builder(
        controller: _scrollController,
        itemBuilder: (context, index) => SizedBox(height: 140, child: Text("$index\n${_paginatedList[index].title}")),
        itemCount: _paginatedList.length,
      ),
    );
  }
}
