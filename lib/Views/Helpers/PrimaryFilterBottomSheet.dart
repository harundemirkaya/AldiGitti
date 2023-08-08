// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, file_names

import 'package:flutter/material.dart';

class PrimaryFilterBottomSheet extends StatefulWidget {
  const PrimaryFilterBottomSheet({super.key});

  @override
  State<PrimaryFilterBottomSheet> createState() =>
      _PrimaryFilterBottomSheetState();
}

class _PrimaryFilterBottomSheetState extends State<PrimaryFilterBottomSheet> {
  int? sortRadioValue = 1;
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
            Row(
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
                  onChanged: (int? value) {
                    setState(() {
                      sortRadioValue = value;
                    });
                  },
                )
              ],
            ),
            Row(
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
                  onChanged: (int? value) {
                    setState(() {
                      sortRadioValue = value;
                    });
                  },
                )
              ],
            ),
            Row(
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
                  onChanged: (int? value) {
                    setState(() {
                      sortRadioValue = value;
                    });
                  },
                )
              ],
            ),
            Row(
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
                  onChanged: (int? value) {
                    setState(() {
                      sortRadioValue = value;
                    });
                  },
                )
              ],
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
            Row(
              children: [
                Text(
                  "12:00 - 18:00",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Checkbox(
                    value: twelveEighteenCheck,
                    onChanged: (bool? value) {
                      setState(
                        () {
                          twelveEighteenCheck = value ?? false;
                        },
                      );
                    })
              ],
            ),
            Row(
              children: [
                Text(
                  "18:00'dan Sonra",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Checkbox(
                  value: eighteenAndLaterCheck,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        eighteenAndLaterCheck = value ?? false;
                      },
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Text(
              "Olanaklar",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Row(
              children: [
                Icon(Icons.verified_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Doğrulanmış Profil",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Checkbox(
                  value: verifiedProfileCheck,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        verifiedProfileCheck = value ?? false;
                      },
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.smoke_free_outlined),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "Sigara İçilmeyen",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Spacer(),
                Checkbox(
                  value: dontSmokeCheck,
                  onChanged: (bool? value) {
                    setState(
                      () {
                        dontSmokeCheck = value ?? false;
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
