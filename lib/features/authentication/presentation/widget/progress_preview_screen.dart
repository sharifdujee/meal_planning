import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/utils/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/onboarding_provider.dart';

import 'onboarding_scaffold.dart';

class ProgressPreviewStep extends ConsumerWidget {
  const ProgressPreviewStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {


    // Extract the first number from trainingDays e.g. "2–3 días" → "2"



    return OnboardingScaffold(
      stepIndex: 5,
      title: 'Este es tu punto de partida',
      fontSize: 24.sp,
      image: IconPath.spaceShip,
      buttonLabel: 'Comenzar mi transformación →',
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Projection card ──────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: BoxDecoration(
                color: AppColor.card,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColor.cardBorder),
              ),
              child: Text(
                'No necesitas ser el mejor. Solo necesitas hacer lo que el 75% no hace durante 30 días.',
                style: GoogleFonts.dmSans(
                  color: AppColor.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ── Footnote ─────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                '**Calculado a partir de tu objetivo y frecuencia de entrenamiento semanal.',
                textAlign: TextAlign.left,
                style: GoogleFonts.dmSans(
                  color: AppColor.textMuted,
                  fontSize: 11,
                  height: 1.5,
                ),
              ),
            ),

            const SizedBox(height: 36),

            // ── Day counter ───────────────────────────────────────────────
            Text(
              'Día 0 de 30',
              style: GoogleFonts.dmSans(
                color: AppColor.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              '¡Tu cambio comienza hoy!',
              style: GoogleFonts.dmSans(
                color: AppColor.accent,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}