import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

// ── Providers ──────────────────────────────────────────────────────────────

enum PaymentMethod { applePay, googlePay, card }

final selectedPaymentProvider =
StateProvider<PaymentMethod>((ref) => PaymentMethod.applePay);

final paymentSuccessProvider = StateProvider<bool>((ref) => false);

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
            stops: [0.0, 0.2],
          ),
        ),
        child: SafeArea(
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
                    const SizedBox(width: 12),
                    const Text(
                      'Suscripción',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cómo funciona tu prueba gratuita',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Free plan card
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1F24),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0xFF469271).withValues(alpha: 0.4),
                              width: 1.2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFF469271),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Text(
                                    'GRATIS (Plan Inicial)',
                                    style: TextStyle(
                                      color: Color(0xFF469271),
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Propósito: Empieza a entrenar hoy. Sin coste. Sin compromiso.',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.55),
                                  fontSize: 13,
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 16),
                              const _SectionLabel('Lo que puedes hacer ahora:'),
                              const SizedBox(height: 10),
                              ...[
                                'Seguir tu entrenamiento diario',
                                'Registrar tus sesiones y racha',
                                'Ver tu progreso básico',
                                'Explorar el ranking global',
                              ].map((e) => _FeatureRow(
                                text: e,
                                color: const Color(0xFF469271),
                                icon: Icons.check_circle_outline_rounded,
                              )),
                              const SizedBox(height: 16),
                              const _SectionLabel(
                                  'Lo que desbloqueas al adquirir\nImperfecto Pro:'),
                              const SizedBox(height: 10),
                              ...[
                                'Competir en el ranking y ganar puntos',
                                'Ver todo tu historial y evolución real',
                                'Acceder a estadísticas completas',
                                'Obtener entrenamiento y nutrición\npersonalizados',
                              ].map((e) => _FeatureRow(
                                text: e,
                                color: const Color(0xFFE05C5C),
                                icon: Icons.lock_outline_rounded,
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
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
                    onPressed: () => _showSubscriptionSheet(context),
                    child: const Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showSubscriptionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _SubscriptionSheet(),
    );
  }
}

// ── Subscription bottom sheet ───────────────────────────────────────────────

class _SubscriptionSheet extends StatelessWidget {
  const _SubscriptionSheet();

  @override
  Widget build(BuildContext context) {
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

          // Pro badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF469271).withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF469271).withValues(alpha: 0.4),
              ),
            ),
            child: const Text(
              'IMPERFECTO PRO',
              style: TextStyle(
                color: Color(0xFF469271),
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            '\$8.5 / mes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w800,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Acceso completo a todas las funciones premium',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.5),
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 28),

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
                context.push('/payment');
              },
              child: const Text(
                'Continuar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Cancela en cualquier momento',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.35),
              fontSize: 12,
            ),
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

              // Payment options
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

              // Card fields (only when card selected)
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
          // Success icon
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
            child: const Icon(
              Icons.check_rounded,
              color: Color(0xFF469271),
              size: 28,
            ),
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
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.4),
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 24),

          // Divider
          Container(
            height: 1,
            color: Colors.white.withValues(alpha: 0.08),
          ),
          const SizedBox(height: 16),

          // Breakdown
          _ReceiptRow(label: 'Subtotal', value: '\$7.5'),
          const SizedBox(height: 10),
          _ReceiptRow(label: 'Impuesto', value: '\$1'),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 10),
          _ReceiptRow(
            label: 'Total',
            value: '\$8.5',
            bold: true,
          ),
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
                Navigator.pop(context); // close sheet
                context.go('/navBar');    // go to home — adjust route as needed
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

class _SectionLabel extends StatelessWidget {
  final String text;
  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.2,
        height: 1.4,
      ),
    );
  }
}

class _FeatureRow extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  const _FeatureRow({required this.text, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.75),
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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

class _ReceiptRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const _ReceiptRow({required this.label, required this.value, this.bold = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: bold ? Colors.white : Colors.white.withValues(alpha: 0.55),
            fontSize: bold ? 15 : 14,
            fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: bold ? 16 : 14,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ],
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