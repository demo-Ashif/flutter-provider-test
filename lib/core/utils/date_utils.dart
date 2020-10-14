import 'package:intl/intl.dart';

class DateUtils {
  static String formatDate(final DateTime dateTime) {
    assert(dateTime != null, "DateTime object passed cannot be null");
    return dateTime.toString().split(".")[0];
  }

  static String format(final DateTime dateTime) {
    assert(dateTime != null, "DateTime object passed cannot be null");

    final formatter = DateFormat('dd MMM yy - HH:mm');
    final formattedDate = formatter.format(dateTime);
    return formattedDate;
  }

  static DateTime fromString(String dateTime) {
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.parse(dateTime);
  }

  static String formatByWeekDay(DateTime date) {
    return "${DateFormat.EEEE().format(date)} ${date.day} ${DateFormat.MMM().format(date)} ${date.year}";
  }

  static DateTime makeDateIntoIntervals({DateTime date, int interval = 10}) {
    // Avoid mutating the original date object
    var tempDate = fromDateTime(date);

    // Find the remainder from date by [interval]
    final int remainder = tempDate.minute.remainder(interval);
    if (remainder != 0) {
      tempDate = tempDate.add(Duration(minutes: interval));
      tempDate = tempDate.subtract(Duration(minutes: remainder));
    }

    return tempDate;
  }

  static DateTime today() {
    var now = DateTime.now();
    var today =
        new DateTime(now.year, now.month, now.day, now.hour, now.minute);
    return today;
  }

  static String formatDateForDatePicker(DateTime date) {
    return DateFormat("yyyy-MM-dd HH:mm").format(date);
  }

  static DateTime fromDateTime(DateTime src,
      {int year: null,
      int month: null,
      int day: null,
      int hour: null,
      int minute: null,
      int second: null,
      int millisecond: null}) {
    return new DateTime(
        year == null ? src.year : year,
        month == null ? src.month : month,
        day == null ? src.day : day,
        hour == null ? src.hour : hour,
        minute == null ? src.minute : minute,
        second == null ? src.second : second,
        millisecond == null ? src.millisecond : millisecond);
  }
}
