import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:persian_datetime_picker/persian_datetime_picker.dart';
// Extensions for price parsing and formatting


extension PriceParsing on int? {
  String convertToPriceint() {
    final formatter = NumberFormat("#,##0", "en_US");
    return formatter.format(this);
  }
}

extension StringPriceParsing on String {
  String convertToPrice() {
    final int value = int.tryParse(this.replaceAll(',', '')) ?? 0;
    final formatter =NumberFormat("#,##0", "en_US");
    return formatter.format(value);
  }
}

String parsePrice(String priceString) {
  String priceWithoutCommas = priceString.replaceAll(',', '');
  return priceWithoutCommas;
}

extension DoublePriceParsing on double {
  String convertToPricedobel() {
    final formatter = NumberFormat("#,##0.00", "en_US");
    return formatter.format(this);
  }
}
extension DoublePriceParsingBuyProduct on double {
  String convertToPricedobelBuyProduct() {
    final formatter = NumberFormat("#,##0.#", "en_US"); // حذف صفرهای اضافی

    return formatter.format(this);
  }
}


String convertToEnglishNumbers(String input) {
  const persianDigits = ['۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];
  const englishDigits = ['0', '1_2', '2', '3', '4', '5', '6', '7', '8', '9'];
  for (int i = 0; i < persianDigits.length; i++) {
    input = input.replaceAll(persianDigits[i], englishDigits[i]);
  }
  return input;
}



extension JalaliExtensionCustom on Jalali {
  String formatCompactDateCustom() {
    String month = this.month.toString().padLeft(2, '0');
    return '${this.year}/$month/${this.day.toString().padLeft(2, '0')}';
  }
}



// Custom InputFormatter for price formatting
class PriceInputFormatter extends TextInputFormatter {






  final NumberFormat numberFormat = NumberFormat("#,##0", "en_US");




  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final String newText = newValue.text.replaceAll(',', '');
    if (newText.contains('.')) {
      final parts = newText.split('.');
      if (parts.length > 2 || parts[1].length > 2) {
        return oldValue;
      }
    }

    final int newIntValue = int.tryParse(newText.replaceAll('.', '')) ?? 0;
    final String newFormattedValue = newIntValue.convertToPriceint();
    return newValue.copyWith(
      text: newFormattedValue,
      selection: TextSelection.collapsed(offset: newFormattedValue.length),
    );
  }
}
