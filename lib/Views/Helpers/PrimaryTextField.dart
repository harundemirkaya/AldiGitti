// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String placeholderText;
  final ValueChanged<String>? onChanged;
  final bool isTelephoneNumber;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.placeholderText,
    this.onChanged,
    this.isTelephoneNumber = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (onChanged != null) ? onChanged! : (String value) {},
      inputFormatters: isTelephoneNumber
          ? [
              FilteringTextInputFormatter.digitsOnly,
              _TurkishPhoneNumberFormatter()
            ]
          : [],
      keyboardType:
          isTelephoneNumber ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        hintText: placeholderText,
        filled: true,
        prefixIcon: Icon(icon),
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(12.0),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFFE4DFDF),
            width: 1.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: Color(0xFFE4DFDF),
            width: 1.0,
          ),
        ),
      ),
    );
  }
}

class _TurkishPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;
    if (newText.length <= 1 && !newText.startsWith('05')) {
      newText = '05$newText';
    }

    if (!newText.startsWith('05')) {
      return oldValue;
    }

    if (newText.length > 4) {
      newText =
          newText.replaceRange(4, newText.length, ' ${newText.substring(4)}');
    }
    if (newText.length > 8) {
      newText =
          newText.replaceRange(8, newText.length, ' ${newText.substring(8)}');
    }
    if (newText.length > 11) {
      newText =
          newText.replaceRange(11, newText.length, ' ${newText.substring(11)}');
    }

    if (newText.length > 14) {
      return oldValue;
    }

    return TextEditingValue(
      text: newText,
      selection: newValue.selection.copyWith(
        baseOffset: newText.length,
        extentOffset: newText.length,
      ),
    );
  }
}
