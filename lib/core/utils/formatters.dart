import 'package:intl/intl.dart';

class Formatters {
  static String currency(double amount) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(amount);
  }

  static String compactCurrency(double amount) {
    return NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 0)
        .format(amount);
  }

  static String number(int value) {
    return NumberFormat('#,##0').format(value);
  }
}
