
import 'package:intl/intl.dart';

class MyDateUtils{
  static String formatTaskDate(DateTime dateTime){
    var formater = DateFormat("yyyy MMM dd");
    return formater.format(dateTime);
  }


}