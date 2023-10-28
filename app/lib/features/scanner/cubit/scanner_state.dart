import 'package:app/core/state/bloc_state_status.dart';
import 'package:equatable/equatable.dart';

class ScannerState extends Equatable {
  const ScannerState._({
    required this.code,
    required this.status,
    this.errorMessage,
  });

  const ScannerState.initial()
      : code = null,
        status = BlocStateStatus.initial,
        errorMessage = null;
  final String? code;
  final BlocStateStatus status;
  final String? errorMessage;

  ScannerState copyWith({String? code, BlocStateStatus? status}) {
    return ScannerState._(
      code: code ?? this.code,
      status: status ?? this.status,
      // ignore: avoid_redundant_argument_values
      errorMessage: null,
    );
  }

  ScannerState copyWithError(String errorMessage) {
    return ScannerState._(
      code: code,
      status: BlocStateStatus.failure,
      errorMessage: errorMessage,
    );
  }

  bool get hasError => errorMessage != null;

  @override
  List<Object?> get props => [code, status, errorMessage];
}
