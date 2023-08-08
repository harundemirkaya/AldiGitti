// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class PrimaryNextButton extends StatelessWidget {
  final String buttonText;
  final IconData? buttonIcon;
  final VoidCallback onPressed;
  final bool isDoubleInfinity;

  const PrimaryNextButton({
    Key? key,
    required this.buttonText,
    this.buttonIcon,
    required this.onPressed,
    this.isDoubleInfinity = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isDoubleInfinity ? double.infinity : 271,
      height: 58,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: <Widget>[
            Spacer(),
            Text(
              buttonText,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            Spacer(),
            if (buttonIcon != null)
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(61, 86, 240, 1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  buttonIcon,
                  color: Colors.white,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
