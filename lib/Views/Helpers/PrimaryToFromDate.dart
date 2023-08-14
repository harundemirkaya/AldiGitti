// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, file_names

import 'package:aldigitti/Provider/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PrimaryToFromDate extends StatefulWidget {
  const PrimaryToFromDate({super.key});

  @override
  State<PrimaryToFromDate> createState() => _PrimaryToFromDateState();
}

class _PrimaryToFromDateState extends State<PrimaryToFromDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    final screenSize = MediaQuery.of(context).size;
    var formatter = DateFormat('dd/MM/yyyy');
    String formattedDate = formatter.format(selectedDate);
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        height: screenSize.height * 80 / 812,
        width: screenSize.width * 0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromRGBO(246, 246, 246, 1),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Text(
                "Tarih",
                style: TextStyle(
                    fontSize: 16, color: Color.fromRGBO(144, 144, 144, 1)),
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
