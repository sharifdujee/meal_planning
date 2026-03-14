import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_planning/features/authentication/presentation/widget/primary_button.dart';

import '../../../../core/design_system/app_color.dart';
import '../../provider/onboarding_provider.dart';

class OnboardingScaffold extends ConsumerWidget {
  final int stepIndex;
  final String title;
  final double? fontSize;
  final String image;
  final Widget body;
  final String buttonLabel;
  final VoidCallback? onNext;
  final bool canProceed;
  final Widget? footer;

  const OnboardingScaffold({
    super.key,
    required this.stepIndex,
    required this.title,
    this.fontSize,
    required this.image,
    required this.body,
    this.buttonLabel = 'Siguiente →',
    this.onNext,
    this.canProceed = true,
    this.footer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(onboardingProvider.notifier);
    final displayStep = stepIndex + 1;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          center: Alignment(-0.9, -1.0),
          radius: 1.3,
          colors: [
            AppColor.gradientStart,
            AppColor.gradientMid,
            Color(0xFF0E1115),
            AppColor.background,
          ],
          stops: [0.0, 0.35, 0.75, 1.0],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: Row(
                children: [
                  if (stepIndex > 0)
                    GestureDetector(
                      onTap: notifier.prevStep,
                      child: Icon(Icons.arrow_back,
                          color: AppColor.primary, size: 30),
                    )
                  else
                    const SizedBox(width: 36),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    margin: EdgeInsets.only(left: 73.w),
                    child: Text(
                      'Paso $displayStep de 7',
                      style: GoogleFonts.dmSans(
                        color: AppColor.textSecondary,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Progress dots
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (i) {
                  final active = i < displayStep;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 40.w,
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: active ? AppColor.accent : AppColor.textMuted,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 28),

            // Icon
            Container(
              padding: EdgeInsets.all(14.sp),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(800.r),
                color: const Color(0xFF6BC799).withValues(alpha: 0.12),
              ),
              margin: EdgeInsets.symmetric(horizontal: 150.w),
              child: Image.asset(image),
            ),

            SizedBox(height: 16.h),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                title,
                style: GoogleFonts.dmSans(
                  color: AppColor.textPrimary,
                  fontSize: fontSize ?? 26.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Body
            Expanded(child: body),

            // Bottom area
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              child: Column(
                children: [
                  PrimaryButton(
                    label: buttonLabel,
                    onTap: canProceed
                        ? () {
                      if (onNext != null) {
                        onNext!();
                        return;
                      }
                      final currentStep =
                          ref.read(onboardingProvider).step;
                      if (currentStep == 5) {
                        log("Text is Pressed");
                        // ✅ GoRouter — matches your '/navBar' route
                        context.go('/createAccount');
                      } else {
                        notifier.nextStep();
                      }
                    }
                        : null,
                  ),
                  if (footer != null) ...[
                    const SizedBox(height: 12),
                    footer!,
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}