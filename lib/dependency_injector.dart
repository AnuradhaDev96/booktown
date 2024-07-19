import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import 'src/services/local_store.dart';

abstract class DependencyInjector {
  /// Inject dependencies with get_it
  static void injectDependencies() {
    GetIt.instance.registerLazySingleton<Logger>(() => Logger());
    GetIt.instance.registerLazySingleton<LocalStore>(() => LocalStore());
  }
}
