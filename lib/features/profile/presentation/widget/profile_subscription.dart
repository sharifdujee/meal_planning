import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/features/profile/presentation/widget/plan_selection_sheet.dart';
import 'feature_table_row.dart';


// ── Providers ──────────────────────────────────────────────────────────────

enum PaymentMethod { applePay, googlePay, card }
enum PlanType { annual, monthly }

final selectedPaymentProvider =
StateProvider<PaymentMethod>((ref) => PaymentMethod.applePay);

final paymentSuccessProvider = StateProvider<bool>((ref) => false);

final selectedPlanProvider =
StateProvider<PlanType>((ref) => PlanType.annual);

// ── ProfileSubscription (entry point) ──────────────────────────────────────

class ProfileSubscription extends ConsumerWidget {
  const ProfileSubscription({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0x2B469271), Color(0xFF0E1115)],
            stops: [0.0, 0.25],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_rounded,
                              color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // Big headline
                    const Text(
                      'Lleva tu entrenamiento al siguiente nivel',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        height: 1.25,
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),

              // Feature comparison table
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      // Column headers
                      Row(
                        children: [
                          const Expanded(flex: 5, child: SizedBox()),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                'GRATIS',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.5),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Center(
                              child: Text(
                                'PRO',
                                style: TextStyle(
                                  color: const Color(0xFF469271),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // Feature rows
                      FeatureTableRow(
                        feature: 'Seguir tu entrenamiento diario',
                        hasGratis: true,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: 'Registrar tus sesiones y racha',
                        hasGratis: true,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: 'Ver tu progreso básico',
                        hasGratis: true,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: 'Explorar el ranking global',
                        hasGratis: true,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: "Competir en el ranking y ganar puntos",
                        hasGratis: false,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: 'Acceder a estadísticas completas',
                        hasGratis: false,
                        hasPro: true,
                      ),
                      FeatureTableRow(
                        feature: 'Obtener entrenamiento y nutrición personalizados',
                        hasGratis: false,
                        hasPro: true,
                      ),



                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),

              // Continue button
              Container(
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                child: SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: CustomButton(
                    text: "Continuar",
                    onPressed: () => _showPlanSheet(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPlanSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const PlanSelectionSheet(),
    );
  }
}















