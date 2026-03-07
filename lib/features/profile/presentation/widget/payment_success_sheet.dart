import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/features/profile/presentation/widget/recipet_row.dart';

class PaymentSuccessSheet extends StatelessWidget {
  const PaymentSuccessSheet({super.key});

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
            '€9.99',
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
          ReceiptRow(label: 'Subtotal', value: '€8.99'),
          const SizedBox(height: 10),
          ReceiptRow(label: 'Impuesto', value: '€1'),
          const SizedBox(height: 10),
          Container(height: 1, color: Colors.white.withValues(alpha: 0.08)),
          const SizedBox(height: 10),
          ReceiptRow(label: 'Total', value: '€9.99', bold: true),
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