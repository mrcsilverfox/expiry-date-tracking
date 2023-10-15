import 'package:app/core/state/bloc_state_status.dart';
import 'package:app/features/scanner/domain/qr_code_scanner_state.dart';
import 'package:bloc/bloc.dart';

class QrCodeScannerCubit extends Cubit<QrCodeScannerState> {
  QrCodeScannerCubit() : super(const QrCodeScannerState.initial());

  void setCode(String value) => emit(
        state.copyWith(code: value, status: BlocStateStatus.success),
      );

  void reset() => emit(const QrCodeScannerState.initial());
}
