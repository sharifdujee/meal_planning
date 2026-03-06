
import 'package:flutter/material.dart';
import 'package:meal_planning/core/global/custom_text.dart';

class WeekScreen extends StatelessWidget {
  const WeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: "Week Screen"),
      ),
    );
  }
}
