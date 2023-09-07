// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class ProfileEditRow extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  const ProfileEditRow({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  State<ProfileEditRow> createState() => _ProfileEditRowState();
}

class _ProfileEditRowState extends State<ProfileEditRow> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          Spacer(),
          Icon(widget.icon),
        ],
      ),
    );
  }
}
