
import 'package:flutter/material.dart';

class ActiveModule {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  bool isEnabled;

  ActiveModule({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isEnabled,
  });
}