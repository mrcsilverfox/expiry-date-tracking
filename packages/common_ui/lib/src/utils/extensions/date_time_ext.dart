///
extension DateTimeExt on DateTime {
  /// Returns only date part: year, month, and day of a datetime.
  DateTime toDate() => DateTime(year, month, day);
}
