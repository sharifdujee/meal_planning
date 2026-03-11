
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/features/registration/provider/workout_log_provider.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log =ref.watch(workoutLogProvider);
    final notifire = ref.read(workoutLogProvider);

    return Scaffold(
      body: Center(
        child: CustomText(text: "Registration Screen"),
      ),
    );
  }
}
