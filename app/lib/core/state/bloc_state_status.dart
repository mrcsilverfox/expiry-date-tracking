enum BlocStateStatus {
  initial,
  progress,
  success,
  failure;

  bool get isInitial => this == BlocStateStatus.initial;
  bool get isProgress => this == BlocStateStatus.progress;
  bool get isSuccess => this == BlocStateStatus.success;
  bool get isFailure => this == BlocStateStatus.failure;

  static BlocStateStatus fromName(String name) =>
      BlocStateStatus.values.firstWhere((element) => element.name == name);
}
