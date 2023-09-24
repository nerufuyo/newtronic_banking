import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

Future formattedDate(date) async {
  await initializeDateFormatting('id_ID', null);
  final DateFormat formatter = DateFormat('dd MMMM yyyy', 'id_ID');
  final String formatted = formatter.format(date);
  return formatted;
}

String formattedBankNumber(String text) {
  final digitsOnly = text.replaceAll(RegExp(r'\D'), '');
  final formatted = <String>[];
  for (var i = 0; i < digitsOnly.length; i += 4) {
    formatted.add(digitsOnly.substring(i, i + 4));
  }

  return formatted.join(' ');
}
