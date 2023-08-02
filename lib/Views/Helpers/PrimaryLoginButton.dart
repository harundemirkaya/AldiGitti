// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PrimaryLoginButton extends StatelessWidget {
  final String iconData;
  final String buttonText;
  final Function onPressed;

  PrimaryLoginButton({
    required this.iconData,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onPressed(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 40.0),
                child: SvgPicture.asset(iconData),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(
                  buttonText,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
