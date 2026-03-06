import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/onboarding_provider.dart';
import '../screen/profile_set_up.dart';
import 'onboarding_scaffold.dart';

class TrainingDaysStep extends ConsumerWidget {
  const TrainingDaysStep({super.key});

  static const _options = ['2–3 días', '3–4 días', '5+ días'];

  static const _hints = [
    'Incluso 3 días a la semana pueden cambiar tu cuerpo en 30 días.',
    'Entrenar 3-4 días es ideal para ganar músculo y perder grasa.',
    'Entrenar 5+ días requiere buena recuperación y descanso.',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    final selectedIndex = _options.indexOf(state.trainingDays ?? '');
    final hint = selectedIndex >= 0 ? _hints[selectedIndex] : _hints[0];

    return OnboardingScaffold(
      stepIndex: 4,
      title: '¿Cuántos días puedes entrenar por semana?',
      image: IconPath.calender,
      canProceed: state.trainingDays != null,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Option row ──────────────────────────────────────────────────
            Row(
              children: List.generate(_options.length, (i) {
                final o = _options[i];
                final selected = state.trainingDays == o;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: i < _options.length - 1 ? 10 : 0),
                    child: GestureDetector(
                      onTap: () => notifier.setTrainingDays(o),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColor.accentDim.withValues(alpha: 0.20)
                              : AppColor.card,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: selected
                                ? AppColor.accent
                                : AppColor.cardBorder,
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Checkbox / circle indicator
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: selected
                                    ? AppColor.accent
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: selected
                                      ? AppColor.accent
                                      : AppColor.textMuted,
                                  width: 1.5,
                                ),
                              ),
                              child: selected
                                  ? const Icon(Icons.check_rounded,
                                  color: Colors.black, size: 14)
                                  : null,
                            ),
                            const SizedBox(height: 14),
                            // Label
                            Text(
                              o,
                              style: GoogleFonts.dmSans(
                                color: AppColor.textPrimary,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),

            // ── Hint box ────────────────────────────────────────────────────
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: Container(
                key: ValueKey(hint),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: AppColor.accentDim.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColor.accent.withValues(alpha: 0.25),
                    width: 1,
                  ),
                ),
                child: Text(
                  hint,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.dmSans(
                    color: AppColor.textSecondary,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}