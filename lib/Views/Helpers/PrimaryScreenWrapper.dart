// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ScreenWrapper extends StatelessWidget {
  final Widget child;

  const ScreenWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
