// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, file_names

import 'package:aldigitti/Providers/DataProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimarySetClock extends StatefulWidget {
  const PrimarySetClock({super.key});

  @override
  State<PrimarySetClock> createState() => _PrimarySetClockState();
}

class _PrimarySetClockState extends State<PrimarySetClock> {
  TextEditingController departureTimeController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null &&
        selectedTime != TimeOfDay.fromDateTime(DateTime.now())) {
      final selectedTimeString = selectedTime.format(context);
      controller.text = selectedTimeString;

      final dataProvider = Provider.of<DataProvider>(context, listen: false);
      if (controller == departureTimeController) {
        dataProvider.setDriverDepartureTime(selectedTimeString);
      } else {
        dataProvider.setDriverArrivalTime(selectedTimeString);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextFormField(
            controller: departureTimeController,
            decoration: InputDecoration(
              labelText: 'Kalkış Saati',
              alignLabelWithHint: true,
            ),
            readOnly: true,
            onTap: () {
              _selectTime(context, departureTimeController);
            },
          ),
        ),
        SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            controller: arrivalTimeController,
            decoration: InputDecoration(
              labelText: 'Varış Saati',
              alignLabelWithHint: true,
            ),
            readOnly: true,
            onTap: () {
              _selectTime(context, arrivalTimeController);
            },
          ),
        ),
      ],
    );
  }
}
