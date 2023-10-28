import 'dart:io';

import 'package:common_ui/src/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
abstract class DateTimePicker {
  static const _borderRadius = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    ),
  );

  ///
  static Future<DateTime?> iOSPickDateTime({
    required BuildContext context,
    required DateTime initialDate,
    required CupertinoDatePickerMode mode,
    DateTime? minDateTime,
  }) async {
    minDateTime ??= DateTime.utc(1900);
    assert(Platform.isIOS, 'The platform must be iOS');

    final isDate = mode == CupertinoDatePickerMode.date;
    if (isDate) {
      // If the mode is `date`, the minDateTime must be a UTC Date.
      // ignore: parameter_assignments
      minDateTime = minDateTime.toDate();
      initialDate = initialDate.toDate();
    }

    final dt = await showModalBottomSheet<DateTime?>(
      context: context,
      shape: _borderRadius,
      builder: (BuildContext builder) {
        var tempSelectedDate = initialDate;
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: Container(
            height: 280,
            decoration: const BoxDecoration(
              color: Color(0xffffffff),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    CupertinoButton(
                      onPressed: () => Navigator.of(context).pop(null),
                      // FIXME: l10n
                      child: const Text('Annulla'),
                    ),
                    CupertinoButton(
                      onPressed: () =>
                          Navigator.of(context).pop(tempSelectedDate),
                      // FIXME: l10n
                      child: const Text('Fatto'),
                    ),
                  ],
                ),
                const Divider(
                  height: 0,
                  thickness: 1,
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    mode: mode,
                    onDateTimeChanged: (picked) {
                      tempSelectedDate = isDate ? picked.toDate() : picked;
                    },
                    initialDateTime: initialDate,
                    minimumDate: minDateTime,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    return isDate ? dt?.toDate() : dt;
  }

  ///
  static Future<DateTime?> androidPickDate({
    required BuildContext context,
    required DateTime initialDate,
    DateTime? minDateTime,
  }) async {
    assert(Platform.isAndroid, 'Platform must be Android');

    initialDate = initialDate.toDate();
    minDateTime = minDateTime?.toDate() ?? DateTime.utc(1900);

    final dt = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: minDateTime,
      // TODO: [flutter >= 3.4.0]
      // remove after PR: https://github.com/flutter/flutter/pull/107268
      // is merged and flutter 3.4.0 released
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light(useMaterial3: true),
          child: child!,
        );
      },
      lastDate: DateTime.utc(2200),
    );

    return dt?.toDate();
  }
}
