// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

class PrimaryFilterBottomSheet extends StatefulWidget {
  final Function(int)? onSortSelected;
  const PrimaryFilterBottomSheet({
    super.key,
    this.onSortSelected,
  });

  @override
  State<PrimaryFilterBottomSheet> createState() =>
      _PrimaryFilterBottomSheetState();
}

class _PrimaryFilterBottomSheetState extends State<PrimaryFilterBottomSheet> {
  int? sortRadioValue = 0;
  bool twelveEighteenCheck = false;
  bool eighteenAndLaterCheck = false;
  bool verifiedProfileCheck = false;
  bool dontSmokeCheck = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Filtrele",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.close,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Sırala",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(1);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.timer_outlined),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "En Erken Kalkış Saati",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 1,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(2);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.attach_money),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "En Düşük Fiyat",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 2,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(3);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Kalkış Yerine Yakın",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 3,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(4);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.directions_walk),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Varış Yerine Yakın",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 4,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Kalkış Saati",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(5);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Text(
                    "12:00 - 18:00",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 5,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                if (widget.onSortSelected != null) {
                  widget.onSortSelected!(6);
                  Navigator.pop(context);
                }
              },
              child: Row(
                children: [
                  Text(
                    "18:00'dan Sonra",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Radio(
                    value: 6,
                    groupValue: sortRadioValue,
                    onChanged: (int? value) {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
