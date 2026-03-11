import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/profile/presentation/widget/payment_option.dart';
import 'package:meal_planning/features/profile/presentation/widget/payment_success_sheet.dart';
import 'package:meal_planning/features/profile/presentation/widget/profile_subscription.dart';

import '../../../../core/design_system/app_color.dart';
import '../../../../core/utils/icon_path.dart';
import 'card_input_field.dart';


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

              PaymentOption(
                method: PaymentMethod.applePay,
                selected: selected,
                label: 'Apple Pay',
                icon: Container(

                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                            width: 0.58,
                            color: Color(0xFFD9D9D9)
                        )
                    ),

                    child: Image.asset(IconPath.applePay, width: 33.w,height: 14.h,)),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.applePay,
              ),
              const SizedBox(height: 12),
              PaymentOption(
                method: PaymentMethod.googlePay,
                selected: selected,
                label: 'Google Pay',
                icon: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                    decoration: BoxDecoration(
                        color: AppColor.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                            width: 0.58,
                            color: Color(0xFFD9D9D9)
                        )
                    ),
                    child: Image.asset(IconPath.googlePay, width: 33.w,height: 14.h,)),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.googlePay,
              ),
              SizedBox(height: 12.h),
              PaymentOption(
                method: PaymentMethod.card,
                selected: selected,
                label: 'Crédito/Débito',
                icon: Image.asset(IconPath.card, width: 33.w,height: 14.h,),
                onTap: () => ref
                    .read(selectedPaymentProvider.notifier)
                    .state = PaymentMethod.card,
              ),

              if (selected == PaymentMethod.card) ...[
                const SizedBox(height: 20),
                CardInputField(hint: 'Número de tarjeta', icon: Icons.credit_card_rounded),
                const SizedBox(height: 10),
                Row(
                  children: const [
                    Expanded(child: CardInputField(hint: 'MM/AA', icon: Icons.date_range_rounded)),
                    SizedBox(width: 10),
                    Expanded(child: CardInputField(hint: 'CVV', icon: Icons.lock_outline_rounded)),
                  ],
                ),
                const SizedBox(height: 10),
                CardInputField(hint: 'Nombre en la tarjeta', icon: Icons.person_outline_rounded),
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
                  child:  Text(
                    'Enviar',
                    style: TextStyle(
                      fontSize: 16.sp,
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
      builder: (_) => const PaymentSuccessSheet(),
    );
  }
}