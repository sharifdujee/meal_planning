import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import '../../provider/seassion _time_card_provider.dart';

class TrainTodayBottomsheet extends ConsumerStatefulWidget {
  const TrainTodayBottomsheet({super.key});

  @override
  ConsumerState<TrainTodayBottomsheet> createState() => _TrainTodayBottomsheetState();
}

class _TrainTodayBottomsheetState extends ConsumerState<TrainTodayBottomsheet> {
  // Local UI state for selection inside the bottom sheet
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final log = ref.watch(seassionWorkoutLogProvider);
    final notifier = ref.read(seassionWorkoutLogProvider.notifier);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: const BoxDecoration(
        color: Color(0xFF10151B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 70.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),

          // Options List
          _buildOption(
            index: 0,
            icon: IconPath.star,
            title: "Entrenamiento Rápido (IA)",
            subtitle: "Sesión corta generada a partir de tus preferencias",
            isAvailable: true,
          ),
          SizedBox(height: 16.h),
          _buildOption(
            index: 1,
            icon: IconPath.redo,
            title: "Repite el último entrenamiento",
            subtitle: "Sin entrenamientos previos",
            isAvailable: false,
          ),
          SizedBox(height: 16.h),
          _buildOption(
            index: 2,
            icon: IconPath.calender,
            title: "Elige entre mis planes",
            subtitle: "No hay entrenamientos en tu plan",
            isAvailable: false,
          ),
          SizedBox(height: 16.h),
          _buildOption(
            index: 3,
            icon: Icons.assignment_outlined,
            title: "Entrenamiento de registro",
            subtitle: "Ahorra tiempo en tu entrenamiento manual.",
            isAvailable: true,
          ),

          SizedBox(height: 24.h),
          // --- Action Buttons ---
          _buildButton(
            text: "Comenzar",
            backgroundColor: const Color(0xFF469271),
            onTap: () {
              Navigator.pop(context);
              switch (selectedIndex) {
                case 0:
                  notifier.activate();
                  break;
                case 3:
                  context.push('/registrationScreen');
                  break;
              }
            },
          ),

          SizedBox(height: 12.h),

          _buildButton(
            text: "Cancelar",
            backgroundColor: Colors.transparent,
            borderColor: const Color(0xFF469271),
            onTap: () => Navigator.pop(context),
          ),


          SizedBox(height: 34.h),
        ],
      ),
    );
  }

  /// Reusable Tile Widget
  Widget _buildOption({
    required int index,
    required dynamic icon,
    required String title,
    required String subtitle,
    required bool isAvailable,
  }) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: isAvailable ? () => setState(() => selectedIndex = index) : null,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        opacity: isAvailable ? 1.0 : 0.4,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFF202122),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF2FC67A) : const Color(0xFF383A42),
              width: isSelected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1C3930) : const Color(0xFF2A2B2C),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: icon is IconData
                    ? Icon(icon, size: 20.sp, color: Colors.white)
                    : Image.asset(icon, height: 20.h, width: 20.w, color: Colors.white),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subtitle,
                      fontSize: 11.sp,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  /// Simplified Button Builder
  Widget _buildButton({
    required String text,
    required VoidCallback onTap,
    required Color backgroundColor,
    Color borderColor = Colors.transparent,
    double height = 48,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: height.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
            color: borderColor,
            width: 1.5,
          ),
        ),
        child: CustomText(
          text: text,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }
}