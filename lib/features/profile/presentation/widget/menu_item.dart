import 'package:flutter/material.dart';

class MenuItem {
  final String icon;
  final String label;
  final Color? textColor;
  final VoidCallback? onTap;

  const MenuItem({
    required this.icon,
    required this.label,
    this.textColor,
    this.onTap,
  });
}