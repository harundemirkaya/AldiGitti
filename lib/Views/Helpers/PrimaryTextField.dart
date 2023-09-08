// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String placeholderText;
  final ValueChanged<String>? onChanged;
  final bool isTelephoneNumber;
  final bool isDateField;
  final bool isGenderSelect;
  final bool isIban;

  const PrimaryTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.placeholderText,
    this.onChanged,
    this.isTelephoneNumber = false,
    this.isDateField = false,
    this.isGenderSelect = false,
    this.isIban = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: (onChanged != null) ? onChanged! : (String value) {},
      inputFormatters: isIban
          ? [
              _IbanFormatter(),
            ]
          : isTelephoneNumber
              ? [
                  FilteringTextInputFormatter.digitsOnly,
                  _TurkishPhoneNumberFormatter(),
                ]
              : [],
      keyboardType:
          isTelephoneNumber ? TextInputType.phone : TextInputType.text,
      readOnly: isDateField || isGenderSelect,
      onTap: () async {
        if (isDateField) {
          DateTime? date = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2101),
          );
          if (date != null) {
            final formattedDate = DateFormat('dd/MM/yy').format(date);
            controller.text = formattedDate;
          }
        } else if (isGenderSelect) {
          final gender = await showDialog<String>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Cinsiyet Seçiniz'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Erkek'),
                      onTap: () {
                        Navigator.of(context).pop('Erkek');
                      },
                    ),
                    ListTile(
                      title: Text('Kadın'),
                      onTap: () {
                        Navigator.of(context).pop('Kadın');
                      },
                    ),
                  ],
                ),
              );
            },
          );
          if (gender != null) {
            controller.text = gender;
          }
        }
      },
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

class _IbanFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    if (newText.length < 2) {
      return TextEditingValue(
        text: 'TR',
        selection: TextSelection.collapsed(offset: 2),
      );
    }

    if (newValue.text.length > oldValue.text.length) {
      String potentialNewChar = newText.substring(newText.length - 1);
      if (int.tryParse(potentialNewChar) == null) {
        return oldValue;
      }
    }

    if (newText.length > 26) {
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
