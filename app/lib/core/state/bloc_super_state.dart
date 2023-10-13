import 'package:app/core/state/bloc_state_status.dart';
import 'package:equatable/equatable.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
abstract class BlocSuperState extends Equatable {
  BlocSuperState({
    required this.status,
    required this.error,
  }) : assert(
          status.isFailure && error != null ||
              !status.isFailure && error == null,
          'Message error is must be not null if the state is in failure',
        );

  BlocSuperState.initial()
      : this(
          status: BlocStateStatus.initial,
          error: null,
        );
  final String? error;
  final BlocStateStatus status;

  BlocSuperState copyWith({BlocStateStatus? status});

  BlocSuperState copyWithError(String error);

  @override
  @mustCallSuper
  List<Object?> get props => [status, error];

  @override
  bool? get stringify => false;

  @nonVirtual
  Widget builder({
    required Widget Function() onInProgress,
    required Widget Function(String error) onFailure,
    required Widget Function() onSuccess,
    Widget Function()? initial,
  }) =>
      switch (status) {
        BlocStateStatus.initial => initial?.call() ?? onInProgress(),
        BlocStateStatus.progress => onInProgress(),
        BlocStateStatus.failure => onFailure(error!),
        BlocStateStatus.success => onSuccess(),
      };
}
