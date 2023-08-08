// ignore_for_file: prefer_const_constructors, file_names, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class PrimaryTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData? icon;
  final String placeholderText;

  PrimaryTextField(
      {required this.controller,
      required this.icon,
      required this.placeholderText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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
