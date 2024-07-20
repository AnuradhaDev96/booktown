import 'package:get_it/get_it.dart';

import 'src/bloc/cubits/favorite_books_bloc.dart';
import 'src/services/dio_client.dart';
import 'src/services/implementations/book_repository_impl.dart';
import 'src/services/implementations/favorite_books_repository_impl.dart';
import 'src/services/local_store.dart';
import 'src/services/repositories/book_repository.dart';
import 'src/services/repositories/favorite_books_repository.dart';
import 'src/services/sqflite_client.dart';

abstract class DependencyInjector {
  /// Inject dependencies with get_it
  static void injectDependencies() {
    // Data resources
    GetIt.instance.registerLazySingleton<LocalStore>(() => LocalStore());
    GetIt.instance.registerLazySingleton<DioClient>(() => DioClient());
    GetIt.instance.registerLazySingleton<SqlfliteClient>(() => SqlfliteClient());

    // Services
    GetIt.instance.registerLazySingleton<BookRepository>(() => BookRepositoryImpl());
    GetIt.instance.registerLazySingleton<FavoriteBooksRepository>(() => FavoriteBooksRepositoryImpl());

    // Blocs
    GetIt.instance.registerLazySingleton<FavoriteBooksBloc>(() => FavoriteBooksBloc());
  }
}
