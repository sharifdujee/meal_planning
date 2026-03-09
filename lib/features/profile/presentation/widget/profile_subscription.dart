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
















  @override
  Widget build(BuildContext context) {
    final isSelected = method == selected;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F24),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF469271)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF469271) : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF469271)
                      : Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _CardInputField extends StatelessWidget {
  final String hint;
  final IconData icon;
  const _CardInputField({required this.hint, required this.icon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3), fontSize: 13),
        prefixIcon: Icon(icon, color: Colors.white.withValues(alpha: 0.3), size: 18),
        filled: true,
        fillColor: const Color(0xFF1A1F24),
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}



// ── Payment method icon widgets ─────────────────────────────────────────────

class _ApplePayIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Center(
        child: Text(
          ' Pay',
          style: TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
      ),
    );
  }
}

class _GooglePayIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 26,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Center(
        child: Text(
          'GPay',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

class _CardIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 26,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A56DB), Color(0xFF3B82F6)],
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: const Icon(Icons.credit_card_rounded, color: Colors.white, size: 16),
    );
  }
}

