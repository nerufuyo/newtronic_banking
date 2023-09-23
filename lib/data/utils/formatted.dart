import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future formattedDate(date) async {
  await initializeDateFormatting('id_ID', null);
  final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
  final String formatted = formatter.format(date);
  return formatted;
}
