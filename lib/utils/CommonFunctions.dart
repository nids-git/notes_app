
import 'package:intl/intl.dart';

String formatDate(DateTime date){
  //return DateFormat('dd MMM yyyy hh:mm a').format(date);
  return DateFormat('dd MMM yy hh:mm a').format(date);
}