import 'package:intl/intl.dart';

String toDate(DateTime date){
  return DateFormat('yyyy-MM-dd').format(date);
}