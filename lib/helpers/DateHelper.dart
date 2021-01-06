import 'package:exchange_books/values/Strings.dart';
import 'package:intl/intl.dart';

class DateHelper {

  static String getPublishedYear (String dateString){

    DateTime date = DateTime.tryParse(dateString);

    if(date == null) return dateString;

    return date.year.toString();

  }

  static String getInsertionDateFormatted (DateTime dateTime){

    DateTime localTime = dateTime.toLocal();

    DateFormat dateFormat = DateFormat("dd/MM/yyyy");
    DateFormat timeFormat = DateFormat("HH:mm");
    return dateFormat.format(localTime) + " " + Strings.atTime + " " + timeFormat.format(localTime);
  }

}