import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/cubits/fetch_books_cubit.dart';
import '../../../bloc/states/fetch_books_state.dart';

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
            return ListView.builder(
              itemBuilder: (context, index) => SizedBox(height: 80, child: Text(state.newBooks[index].title)),
              itemCount: state.newBooks.length,
            );
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
