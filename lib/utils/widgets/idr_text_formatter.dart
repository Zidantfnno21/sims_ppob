import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RupiahInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern('id_ID');

  static String format(int value) {
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0);
    return formatter.format(value);
  }

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formatted = _formatter.format(int.parse(digitsOnly));
    final withPrefix = 'Rp $formatted';
    return TextEditingValue(
      text: withPrefix,
      selection: TextSelection.collapsed(offset: withPrefix.length),
    );
  }
}
