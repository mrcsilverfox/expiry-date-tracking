import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormatter {
  DateTimeFormatter(Locale locale) : locale = locale.languageCode;

  DateTimeFormatter.of(BuildContext context)
      : locale = Localizations.localeOf(context).languageCode;

  DateTimeFormatter.en() : locale = 'en';

  DateTimeFormatter.it() : locale = 'it';
  /*
ICU Name                   Skeleton
--------                   --------
DAY                          d
ABBR_WEEKDAY                 E
WEEKDAY                      EEEE
ABBR_STANDALONE_MONTH        LLL
STANDALONE_MONTH             LLLL
NUM_MONTH                    M
NUM_MONTH_DAY                Md
NUM_MONTH_WEEKDAY_DAY        MEd
ABBR_MONTH                   MMM
ABBR_MONTH_DAY               MMMd
ABBR_MONTH_WEEKDAY_DAY       MMMEd
MONTH                        MMMM
MONTH_DAY                    MMMMd
MONTH_WEEKDAY_DAY            MMMMEEEEd
ABBR_QUARTER                 QQQ
QUARTER                      QQQQ
YEAR                         y
YEAR_NUM_MONTH               yM
YEAR_NUM_MONTH_DAY           yMd
YEAR_NUM_MONTH_WEEKDAY_DAY   yMEd
YEAR_ABBR_MONTH              yMMM
YEAR_ABBR_MONTH_DAY          yMMMd
YEAR_ABBR_MONTH_WEEKDAY_DAY  yMMMEd
YEAR_MONTH                   yMMMM
YEAR_MONTH_DAY               yMMMMd
YEAR_MONTH_WEEKDAY_DAY       yMMMMEEEEd
YEAR_ABBR_QUARTER            yQQQ
YEAR_QUARTER                 yQQQQ
HOUR24                       H
HOUR24_MINUTE                Hm
HOUR24_MINUTE_SECOND         Hms
HOUR                         j
HOUR_MINUTE                  jm
HOUR_MINUTE_SECOND           jms
HOUR_MINUTE_GENERIC_TZ       jmv
HOUR_MINUTE_TZ               jmz
HOUR_GENERIC_TZ              jv
HOUR_TZ                      jz
MINUTE                       m
MINUTE_SECOND                ms
SECOND                       s
   */

  final String locale;

  DateFormat get dateTimeWithSeconds =>
      DateFormat('d MMM yyyy, HH:mm:ss', locale);

  DateFormat get monthYear => DateFormat('MMM yyyy', locale);

  DateFormat get shortMonth => DateFormat('MMM', locale);

  DateFormat get month => DateFormat('MMMM', locale);

  DateFormat get year => DateFormat('yyyy');

  DateFormat get day => DateFormat('d', locale);

  DateFormat get abbrWeekday => DateFormat('E', locale);

  DateFormat get prettyDateWithDay => DateFormat('E d MMM yyyy', locale);

  DateFormat get dateWithDay => DateFormat('E d/M/yyyy', locale);

  DateFormat get dateWithDay2 => DateFormat('E dd/MM/yyyy', locale);

  DateFormat get weekday => DateFormat('EEEE', locale);

  DateFormat get prettyDate => DateFormat('d MMM yyyy', locale);

  DateFormat get prettyDate2 => DateFormat('d MMMM yyyy', locale);

  DateFormat get prettyDate3 => DateFormat('E d MMM', locale);

  DateFormat get prettyDate4 => DateFormat('d MMM', locale);

  DateFormat get dateTime => DateFormat('d MMM yyyy, HH:mm', locale);

  DateFormat get dateTimeShortHour => DateFormat('d MMM yyyy, H:mm', locale);

  DateFormat get dateTime2 => DateFormat('d MMMM yyyy, HH:mm', locale);

  DateFormat get dateTime3 => DateFormat('d MMM yyyy, hh:mma', locale);

  DateFormat get dateTimeOfTheWeek => DateFormat('E d MMM yyyy, HH:mm', locale);

  DateFormat get dateTimeOfTheWeek2 =>
      DateFormat('E d MMMM yyyy, HH:mm', locale);

  DateFormat get dateTimeOfTheWeek3 =>
      DateFormat('EEEE d MMMM yyyy, HH:mm', locale);

  DateFormat get dtOfTheWeekShort => DateFormat('E d MMM, HH:mm', locale);

  DateFormat get hHmm => DateFormat('HH:mm');

  DateFormat get hHmm2 => DateFormat('hh:mma');

  DateFormat get ddMMyy => DateFormat('dd/MM/yy');

  DateFormat ddMMYYHhmm = DateFormat('dd/MM/yy, HH:mm');

  /// This format is not supported from the DateFormat.parse() function.
  /// Do not use it if it required to parse its value from string.
  DateFormat unparsableFileTimestamp = DateFormat('yyMMddHHmmssSSS');

  /// Use this format to rename local log files.
  static final DateFormat parsableFileTimestamp =
      DateFormat("yyyy-MM-dd_HH'h'mm'm'ss.SSS");

  DateFormat isoDate = DateFormat('yyyy-MM-dd');
}

class DateTimeUtils {
  /// Compares two [DateTime] objects taking into account that a null value
  /// is always "more in the future" than a not null value
  int compareWithNulls(DateTime? d1, DateTime? d2) {
    if (d1 == null) {
      return d2 != null ? 1 : 0;
    }
    if (d2 == null) {
      return -1;
    }
    return d1.compareTo(d2);
  }

  int compareDateWithNulls(DateTime? d1, DateTime? d2) {
    if (d1 == null) {
      return d2 != null ? 1 : 0;
    }
    if (d2 == null) {
      return -1;
    }
    if (d1.difference(d2).inDays < 0) {
      return -1;
    } else if (d1.difference(d2).inDays > 0) {
      return 1;
    } else {
      return 0;
    }
  }

  bool isSameDate(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
