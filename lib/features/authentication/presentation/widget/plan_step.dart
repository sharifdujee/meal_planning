import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../../core/design_system/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/onboarding_provider.dart';
import '../screen/profile_set_up.dart';
import 'onboarding_scaffold.dart';

class PlanStep extends ConsumerWidget {
  const PlanStep({super.key});

  static const _plans = [
    (
    'completo',                                        // $1 key
    'Plan completo',                                   // $2 title
    'Comidas, calorías y entrenamiento adaptados automáticamente cada semana.', // $3 subtitle
    '🥞',                                             // $4 emoji
    ),
    (
    'estandar',
    'Solo entrenamiento',
    'Entrena con un plan personalizado sin seguimiento nutricional.',
    '🤼‍♂️',
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return OnboardingScaffold(
      stepIndex: 3,
      title: 'El tiempo revela lo que la prisa oculta.',
      fontSize: 16.sp,
      image: IconPath.avocado,
      buttonLabel: 'Seguir mi plan →',
      canProceed: state.planType != null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Sub-heading
            Text(
              '¿Cómo quieres que te guiemos?',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: AppColor.textPrimary,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 24),

            // Plan cards
            ..._plans.map((p) {
              final selected = state.planType == p.$1;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: GestureDetector(
                  onTap: () => notifier.setPlanType(p.$1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColor.accentDim.withValues(alpha: 0.18)
                          : AppColor.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: selected
                            ? AppColor.accent
                            : AppColor.cardBorder,
                        width: selected ? 1.5 : 1,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text content
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                p.$2,
                                style: GoogleFonts.dmSans(
                                  color: AppColor.textPrimary,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                p.$3,
                                style: GoogleFonts.dmSans(
                                  color: AppColor.textSecondary,
                                  fontSize: 13.sp,
                                  height: 1.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Emoji on the right
                        Text(
                          p.$4,
                          style: const TextStyle(fontSize: 28),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),

            const SizedBox(height: 16),

            // Footer note
            Text(
              '**Puedes cambiar esto más adelante.',
              textAlign: TextAlign.center,
              style: GoogleFonts.dmSans(
                color: AppColor.primary,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}