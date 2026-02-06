import 'package:flutter_bloc/flutter_bloc.dart';

extension BlocBaseExtension<T> on BlocBase<T> {
  void maybeEmit(T state) {
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    if (!isClosed) emit(state);
  }
}
