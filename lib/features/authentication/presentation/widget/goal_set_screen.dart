import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/onboarding_provider.dart';
import '../screen/profile_set_up.dart';
import 'goal_card.dart';
import 'onboarding_scaffold.dart';

class GoalsStep extends ConsumerWidget {
  const GoalsStep({super.key});

  static const _goals = [
    ('Perder grasa', IconPath.goalOne),
    ('Ganar músculo', IconPath.goalTwo),
    ('Ponerse en forma', IconPath.goalThree),
    ('Competir en el ranking', IconPath.goalFour),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return OnboardingScaffold(
      stepIndex: 0,
      title: '¿Qué quieres lograr?',
      image: IconPath.target,
      canProceed: state.selectedGoals.isNotEmpty,
      footer: GestureDetector(
        onTap: notifier.nextStep,
        child: Center(
          child: Text(
            'Ya tengo una cuenta',
            style: GoogleFonts.dmSans(
              color: AppColor.textSecondary,
              fontSize: 13.sp,
              decoration: TextDecoration.underline,
              decorationColor: AppColor.textSecondary,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.05,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: _goals.map((g) {
            final selected = state.selectedGoals.contains(g.$1);
            return GoalCard(
              label: g.$1,
              imagePath: g.$2,
              selected: selected,
              onTap: () => notifier.toggleGoal(g.$1),
            );
          }).toList(),
        ),
      ),
    );
  }
}