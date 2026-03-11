
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';



import '../../../../core/design_system/app_color.dart';
import '../../provider/onboarding_provider.dart';
import '../widget/fitness_level.dart';
import '../widget/goal_set_screen.dart';
import '../widget/plan_step.dart';
import '../widget/primary_button.dart';
import '../widget/progress_preview_screen.dart';
import '../widget/subscription_step.dart';
import '../widget/training_step.dart';
import '../widget/user_info_step.dart';

class AppColors {

}




class ProfileSetUp extends ConsumerWidget {
  const ProfileSetUp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final step = ref.watch(onboardingProvider).step;

    final pages = [
      const GoalsStep(),
      const UserInfoStep(),
      const FitnessLevelStep(),
      const PlanStep(),
      const TrainingDaysStep(),
      const ProgressPreviewStep(),
      const SubscriptionStep(),
    ];

    final safeStep = step.clamp(0, pages.length - 1);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppColor.background,
        resizeToAvoidBottomInset: true,
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          transitionBuilder: (child, animation) => FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(CurvedAnimation(
                parent: animation,
                curve: Curves.easeOutCubic,
              )),
              child: child,
            ),
          ),
          child: KeyedSubtree(
            key: ValueKey(safeStep),
            child: pages[safeStep],
          ),
        ),
      ),
    );
  }
}


























// ── Pricing Cards Row ─────────────────────────────────────────────────────────



class PricingCard extends StatefulWidget {
  final String label;
  final String price;
  final String period;
  final bool highlight;
  final String? badge;

  const PricingCard({super.key,
    required this.label,
    required this.price,
    required this.period,
    required this.highlight,
    this.badge,
  });

  @override
  State<PricingCard> createState() => PricingCardState();
}

class PricingCardState extends State<PricingCard> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _selected = !_selected),
      child: AnimatedContainer(
        height: 300.h,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _selected || widget.highlight
              ? AppColor.accentDim.withValues(alpha: 0.18)
              : AppColor.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _selected || widget.highlight
                ? AppColor.accent
                : AppColor.cardBorder,
            width: widget.highlight ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.label,
                          style: GoogleFonts.dmSans(
                            color: AppColor.textSecondary,
                            fontSize: 12,
                          )),
                      if (widget.badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColor.accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(widget.badge!,
                              style: GoogleFonts.dmSans(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(widget.price,
                          style: GoogleFonts.dmMono(
                            color: AppColor.textPrimary,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          )),
                      const SizedBox(width: 4),
                      Text('/ ${widget.period}',
                          style: GoogleFonts.dmSans(
                              color: AppColor.textSecondary,
                              fontSize: 12)),
                    ],
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _selected ? AppColor.accent : Colors.transparent,
                border: Border.all(
                  color: _selected
                      ? AppColor.accent
                      : AppColor.textMuted,
                  width: 1.5,
                ),
              ),
              child: _selected
                  ? const Icon(Icons.check, color: Colors.black, size: 13)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

