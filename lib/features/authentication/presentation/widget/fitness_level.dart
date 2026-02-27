import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/onboarding_provider.dart';
import '../screen/profile_set_up.dart';
import 'onboarding_scaffold.dart';

class FitnessLevelStep extends ConsumerWidget {
  const FitnessLevelStep({super.key});

  static const _levels = [
    ('Principiante', '👶'),
    ('Intermedio', '👦'),
    ('Avanzado', '👨‍🦰'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return OnboardingScaffold(
      stepIndex: 2,
      title: '¿Cuál es tu nivel actual?',
      image: IconPath.weight,
      canProceed: state.fitnessLevel != null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Row 1: Principiante + Intermedio
            Row(
              children: [
                Expanded(
                  child: _LevelCard(
                    label: _levels[0].$1,
                    emoji: _levels[0].$2,
                    selected: state.fitnessLevel == _levels[0].$1,
                    onTap: () => notifier.setFitnessLevel(_levels[0].$1),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _LevelCard(
                    label: _levels[1].$1,
                    emoji: _levels[1].$2,
                    selected: state.fitnessLevel == _levels[1].$1,
                    onTap: () => notifier.setFitnessLevel(_levels[1].$1),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Row 2: Avanzado centered (half width)
            Row(
              children: [
                Expanded(
                  flex: 300,
                  child: _LevelCard(
                    label: _levels[2].$1,
                    emoji: _levels[2].$2,
                    selected: state.fitnessLevel == _levels[2].$1,
                    onTap: () => notifier.setFitnessLevel(_levels[2].$1),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(child: SizedBox()), // empty spacer
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _LevelCard extends StatelessWidget {
  final String label;
  final String emoji;
  final bool selected;
  final VoidCallback onTap;

  const _LevelCard({
    required this.label,
    required this.emoji,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 110,
        decoration: BoxDecoration(
          color: selected
              ? AppColor.accentDim.withValues(alpha: 0.15)
              : AppColor.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? AppColor.accent : AppColor.cardBorder,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              emoji,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.dmSans(
                color: AppColor.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}