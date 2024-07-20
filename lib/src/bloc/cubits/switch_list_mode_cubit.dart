import 'package:flutter_bloc/flutter_bloc.dart';

/// [true] means => New books mode
///
/// [false] means => Search mode
class SwitchBookListModeCubit extends Cubit<bool> {
  SwitchBookListModeCubit() : super(true);

  void switchToListMode() => emit(true);

  void switchToSearchMode() => emit(false);
}
