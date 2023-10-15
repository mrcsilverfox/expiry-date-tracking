import 'package:app/core/state/bloc_state_status.dart';
import 'package:equatable/equatable.dart';

class QrCodeScannerState extends Equatable {

  const QrCodeScannerState._({
    required this.code,
    required this.status,
    this.errorMessage,
  });

  const QrCodeScannerState.initial()
      : code = null,
        status = BlocStateStatus.initial,
        errorMessage = null;
  final String? code;
  final BlocStateStatus status;
  final String? errorMessage;

  QrCodeScannerState copyWith({String? code, BlocStateStatus? status}) {
    return QrCodeScannerState._(
      code: code ?? this.code,
      status: status ?? this.status,
      // ignore: avoid_redundant_argument_values
      errorMessage: null,
    );
  }

  QrCodeScannerState copyWithError(String errorMessage) {
    return QrCodeScannerState._(
      code: code,
      status: BlocStateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [code, status, errorMessage];
}
