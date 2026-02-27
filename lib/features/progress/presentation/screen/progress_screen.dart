
import 'package:flutter/material.dart';
import 'package:meal_planning/core/global/custom_text.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: "Progress Screen"),
      ),
    );
  }
}
