import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/features/profile/presentation/widget/recipet_row.dart';


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
                      _FeatureTableRow(
                        feature: 'Registrar\nentrenamientos',
                        hasGratis: true,
                        hasPro: true,
                      ),
                      _FeatureTableRow(
                        feature: 'Plan de entrenamiento\npersonalizado con IA',
                        hasGratis: false,
                        hasPro: true,
                      ),
                      _FeatureTableRow(
                        feature: 'Escaneo corporal\ncon IA',
                        hasGratis: false,
                        hasPro: true,
                      ),
                      _FeatureTableRow(
                        feature: 'Sobrecarga progresiva\nautomática',
                        hasGratis: false,
                        hasPro: true,
                      ),
                      _FeatureTableRow(
                        feature: 'Rutinas y planes\nilimitados',
                        hasGratis: false,
                        hasPro: true,
                      ),
                      _FeatureTableRow(
                        feature: 'Entrenamientos\npersonalizados IA',
                        hasGratis: false,
                        hasPro: true,
                      ),

                      // Ligas y ranking section
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'Ligas y ranking',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '¡y mucho más por venir!',
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.45),
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ),
                ),
              ),

              // Continue button
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
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
      builder: (_) => const _PlanSelectionSheet(),
    );
  }
}

// ── Feature comparison table row ───────────────────────────────────────────

class _FeatureTableRow extends StatelessWidget {
  final String feature;
  final bool hasGratis;
  final bool hasPro;

  const _FeatureTableRow({
    required this.feature,
    required this.hasGratis,
    required this.hasPro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white.withValues(alpha: 0.07),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Text(
              feature,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.8),
                fontSize: 13.5,
                height: 1.4,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: hasGratis
                  ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 18)
                  : Text(
                '–',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25), fontSize: 16),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
              child: hasPro
                  ? const Icon(Icons.check_rounded,
                  color: Color(0xFF469271), size: 18)
                  : Text(
                '–',
                style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.25), fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Plan Selection Sheet (Image 2 style) ───────────────────────────────────

class _PlanSelectionSheet extends ConsumerWidget {
  const _PlanSelectionSheet();

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
                  '75% de descuento',
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
                            '\$55.88 ',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.35),
                              fontSize: 12,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: Colors.white.withValues(alpha: 0.35),
                            ),
                          ),
                          const Text(
                            '\$8.5 / mes',
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
                        '\$12.99 / mes',
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
                    ? 'Facturado a \$102 / año'
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

// ── PaymentScreen ───────────────────────────────────────────────────────────

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedPaymentProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white, size: 22),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Pago',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.3,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 34),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'Método de Pago',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.55),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 14),

              _PaymentOption(
                method: PaymentMethod.applePay,
                selected: selected,
                label: 'Apple Pay',
                icon: _ApplePayIcon(),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.applePay,
              ),
              const SizedBox(height: 12),
              _PaymentOption(
                method: PaymentMethod.googlePay,
                selected: selected,
                label: 'Google Pay',
                icon: _GooglePayIcon(),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.googlePay,
              ),
              const SizedBox(height: 12),
              _PaymentOption(
                method: PaymentMethod.card,
                selected: selected,
                label: 'Crédito/Débito',
                icon: _CardIcon(),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.card,
              ),

              if (selected == PaymentMethod.card) ...[
                const SizedBox(height: 20),
                _CardInputField(hint: 'Número de tarjeta', icon: Icons.credit_card_rounded),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(child: _CardInputField(hint: 'MM/AA', icon: Icons.date_range_rounded)),
                    SizedBox(width: 10),
                    Expanded(child: _CardInputField(hint: 'CVV', icon: Icons.lock_outline_rounded)),
                  ],
                ),
                const SizedBox(height: 10),
                _CardInputField(hint: 'Nombre en la tarjeta', icon: Icons.person_outline_rounded),
              ],

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF469271),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () => _showSuccessSheet(context, ref),
                  child: const Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _showSuccessSheet(BuildContext context, WidgetRef ref) {
    ref.read(paymentSuccessProvider.notifier).state = true;
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (_) => const _PaymentSuccessSheet(),
    );
  }
}

// ── Payment Success Sheet ───────────────────────────────────────────────────

class _PaymentSuccessSheet extends StatelessWidget {
  const _PaymentSuccessSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F24),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF469271).withValues(alpha: 0.15),
              border: Border.all(
                color: const Color(0xFF469271).withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            child: const Icon(Icons.check_rounded,
                color: Color(0xFF469271), size: 28),
          ),
          const SizedBox(height: 16),
          const Text(
            'Pago Exitoso',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            '\$8.5',
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '10 de febrero de 2026',
            style: TextStyle(color: Colors.white.withValues(alpha: 0.4), fontSize: 13),
          ),
          const SizedBox(height: 24),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 16),
          ReceiptRow(label: 'Subtotal', value: '\$7.5'),
          const SizedBox(height: 10),
          ReceiptRow(label: 'Impuesto', value: '\$1'),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 10),
          ReceiptRow(label: 'Total', value: '\$8.5', bold: true),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF469271),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              onPressed: () {
                Navigator.pop(context);
                context.go('/navBar');
              },
              child: const Text(
                'Hecho',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Sub-widgets ─────────────────────────────────────────────────────────────

class _PaymentOption extends StatelessWidget {
  final PaymentMethod method;
  final PaymentMethod selected;
  final String label;
  final Widget icon;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.method,
    required this.selected,
    required this.label,
    required this.icon,
    required this.onTap,
  });

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