// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:aldigitti/Provider/DataProvider.dart';
import 'package:aldigitti/Views/Helpers/PrimaryLocationSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PrimaryToFrom extends StatefulWidget {
  final bool isPublisher;
  const PrimaryToFrom({
    super.key,
    this.isPublisher = false,
  });

  @override
  State<PrimaryToFrom> createState() => _PrimaryToFromState();
}

class _PrimaryToFromState extends State<PrimaryToFrom> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context, listen: true);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromRGBO(246, 246, 246, 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Stack(
          children: [
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrimaryLocationSelection(
                          isFrom: true,
                          isPublisher: (widget.isPublisher) ? true : false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nereden",
                            style: TextStyle(
                              fontSize: 16,
                              color: Color.fromRGBO(144, 144, 144, 1),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.isPublisher
                                ? dataProvider.driverFromName
                                : dataProvider.customerFromName,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PrimaryLocationSelection(
                          isFrom: false,
                          isPublisher: (widget.isPublisher) ? true : false,
                        ),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            "Nereye",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromRGBO(144, 144, 144, 1)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.isPublisher
                                ? dataProvider.driverToName
                                : dataProvider.customerToName,
                            style: TextStyle(
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () {
                  if (widget.isPublisher) {
                    if (dataProvider.driverToName != "Nereye" &&
                        dataProvider.driverFromName != "Nereden") {
                      var toName = dataProvider.driverToName;
                      var toLat = dataProvider.driverToLat;
                      var toLong = dataProvider.driverToLong;

                      dataProvider.setDriverToName(dataProvider.driverFromName);
                      dataProvider.setDriverToLat(dataProvider.driverFromLat);
                      dataProvider.setDriverToLong(dataProvider.driverFromLong);

                      dataProvider.setDriverFromName(toName);
                      dataProvider.setDriverFromLat(toLat);
                      dataProvider.setDriverFromLong(toLong);
                    }
                  } else {
                    if (dataProvider.customerToName != "Nereye" &&
                        dataProvider.customerFromName != "Nereden") {
                      var toName = dataProvider.customerToName;
                      var toLat = dataProvider.customerToLat;
                      var toLong = dataProvider.customerToLong;

                      dataProvider
                          .setCustomerToName(dataProvider.customerFromName);
                      dataProvider
                          .setCustomerToLat(dataProvider.customerFromLat);
                      dataProvider
                          .setCustomerToLong(dataProvider.customerFromLong);

                      dataProvider.setCustomerFromName(toName);
                      dataProvider.setCustomerFromLat(toLat);
                      dataProvider.setCustomerFromLong(toLong);
                    }
                  }
                },
                child: Icon(
                  Icons.change_circle,
                  size: 66,
                  color: Color.fromRGBO(61, 86, 240, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
