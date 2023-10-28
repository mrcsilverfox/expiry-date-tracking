import 'package:app/core/state/bloc_state_status.dart';
import 'package:app/features/scanner/cubit/scanner_state.dart';
import 'package:bloc/bloc.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(const ScannerState.initial());

  void setCode(String value) => emit(
        state.copyWith(code: value, status: BlocStateStatus.success),
      );

  void reset() => emit(const ScannerState.initial());
}
