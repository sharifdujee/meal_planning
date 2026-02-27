import 'package:flutter/material.dart';
import 'package:meal_planning/core/global/custom_text.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(text: "Ranking Screen"),
      ),
    );
  }
}
