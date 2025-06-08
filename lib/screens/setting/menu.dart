import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final void Function() onTap;
  final Color? iconColor;

  MenuItem({
    required this.title,
    required this.icon,
    required this.onTap,
    this.iconColor,
  });
}
