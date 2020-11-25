import 'package:intl/intl.dart';

class Formatter {
  static toLongDateFromString(String date) {
    var fecha = new DateFormat('yyyy-MM-dd').parse(date);
    var formatDate = new DateFormat.yMMMMd('es_ES');

    return formatDate.format(fecha).toString();
  }

  static toLongDateFromDate(DateTime date) =>
      new DateFormat.yMMMMd('es_ES').format(date).toString();

  static toLongDateWithHour(DateTime date) =>
      new DateFormat.yMMMMd('es_ES').add_jms().format(date).toString();

  static toShortDateWithDayAndMonth(DateTime date) {
    var split = new DateFormat.EEEE('es_ES').add_MMMMd().format(date).toString().split(" ");
    split[0] = split[0][0].toUpperCase() + split[0].substring(1) + ",";
    return split.join(" ");
  }

}