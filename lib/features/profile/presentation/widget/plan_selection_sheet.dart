import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/features/profile/presentation/widget/profile_subscription.dart';


class PlanSelectionSheet extends ConsumerWidget {
  const PlanSelectionSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPlanProvider);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1F24),
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 36),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),

          const Text(
            'Elige tu plan',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          const SizedBox(height: 20),

          // Discount badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF469271).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFF469271).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt_rounded,
                    color: Color(0xFF469271), size: 16),
                const SizedBox(width: 6),
                const Text(
                  '20% de descuento',
                  style: TextStyle(
                    color: Color(0xFF469271),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF469271),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'Oferta Limitada',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Annual plan option
          GestureDetector(
            onTap: () =>
            ref.read(selectedPlanProvider.notifier).state = PlanType.annual,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected == PlanType.annual
                      ? const Color(0xFF469271)
                      : Colors.white.withValues(alpha: 0.12),
                  width: selected == PlanType.annual ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected == PlanType.annual
                          ? const Color(0xFF469271)
                          : Colors.transparent,
                      border: Border.all(
                        color: selected == PlanType.annual
                            ? const Color(0xFF469271)
                            : Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: selected == PlanType.annual
                        ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 13)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Anual',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            '€119.88',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.35),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                          SizedBox(width: 8.w,),
                          const Text(
                            '€59.90 / mes',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'por mes',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Monthly plan option
          GestureDetector(
            onTap: () => ref
                .read(selectedPlanProvider.notifier)
                .state = PlanType.monthly,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: selected == PlanType.monthly
                      ? const Color(0xFF469271)
                      : Colors.white.withValues(alpha: 0.12),
                  width: selected == PlanType.monthly ? 2 : 1,
                ),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 160),
                    width: 22,
                    height: 22,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: selected == PlanType.monthly
                          ? const Color(0xFF469271)
                          : Colors.transparent,
                      border: Border.all(
                        color: selected == PlanType.monthly
                            ? const Color(0xFF469271)
                            : Colors.white.withValues(alpha: 0.3),
                        width: 2,
                      ),
                    ),
                    child: selected == PlanType.monthly
                        ? const Icon(Icons.check_rounded,
                        color: Colors.white, size: 13)
                        : null,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Mensual',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text(
                        '€9.99 / mes',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'por mes',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.4),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Cancel anytime
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.shield_outlined,
                  color: Color(0xFF469271), size: 14),
              const SizedBox(width: 6),
              Text(
                'Cancela cuando quieras',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
                context.push('/payment');
              },
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Consumer(
            builder: (context, ref, _) {
              final plan = ref.watch(selectedPlanProvider);
              return Text(
                plan == PlanType.annual
                    ? 'Facturado a €23.98 / año'
                    : 'Facturado mensualmente',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.35),
                  fontSize: 12,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}