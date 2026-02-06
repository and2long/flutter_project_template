import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_project_template/core/blocs/error_handler.dart';
import 'package:flutter_project_template/core/blocs/extension.dart';
import 'package:flutter_project_template/core/blocs/health/health_state.dart';
import 'package:flutter_project_template/core/repos/health_repo.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class HealthCubit extends Cubit<HealthState> {
  final HealthRepo _repo;

  HealthCubit(HealthRepo repo) : _repo = repo, super(HealthInitialState());

  Future<void> check() async {
    try {
      SmartDialog.showLoading();
      await _repo.check();
      maybeEmit(HealthCheckSuccessState());
    } catch (e, s) {
      handleError(e, stackTrace: s);
    } finally {
      SmartDialog.dismiss();
    }
  }
}
