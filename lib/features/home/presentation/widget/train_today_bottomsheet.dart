import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

class TrainTodayBottomsheet extends StatefulWidget {
  const TrainTodayBottomsheet({super.key});

  @override
  State<TrainTodayBottomsheet> createState() => _TrainTodayBottomsheetState();
}

class _TrainTodayBottomsheetState extends State<TrainTodayBottomsheet> {
  // 0: AI, 1: Repeat, 2: Plan, 3: Log
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
      decoration: const BoxDecoration(
        color: Color(0xFF10151B),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Wrap content height
        children: [
          // Drag handle
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 20.h),
              width: 70.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
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
            isAvailable: false, // Not available
          ),
          SizedBox(height: 16.h),
          _buildOption(
            index: 2,
            icon: IconPath.calender,
            title: "Elige entre mis planes",
            subtitle: "No hay entrenamientos en tu plan",
            isAvailable: false, // Not available
          ),
          SizedBox(height: 16.h),
          _buildOption(
            index: 3,
            icon: Icons.assignment_outlined,
            title: "Entrenamiento de registro",
            subtitle: "Ahorra tiempo en tu entrenamiento manual con ejercicios, series, repeticiones y peso.",
            isAvailable: true,
          ),

          SizedBox(height: 24.h),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: "Cancelar",
                  backgroundColor: Colors.transparent,
                  borderWidth: 1,
                  borderGradient: const LinearGradient(colors: [Color(0xFF383A42), Color(0xFF383A42)]),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: "Comenzar",
                  onPressed: () {
                    Navigator.pop(context);
                    switch(selectedIndex){
                      case 0:
                        context.push('/myProteinPage');
                      case 3:
                        context.push('/registrationScreen');
                    }
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 30.h), // Bottom padding for safety
        ],
      ),
    );
  }

  // Reusable Tile Widget
  Widget _buildOption({
    required int index,
    required dynamic icon,
    required String title,
    required String subtitle,
    required bool isAvailable,
  }) {
    bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: isAvailable ? () => setState(() => selectedIndex = index) : null,
      child: Opacity(
        opacity: isAvailable ? 1.0 : 0.5,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          decoration: BoxDecoration(
            color: const Color(0xFF202122),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isSelected ? const Color(0xFF2FC67A) : const Color(0xFF383A42),
              width: isSelected ? 2 : 1,
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
                    ? Icon(icon, size: 20.sp, color: isAvailable ? Colors.white : Colors.grey)
                    : Image.asset(
                  icon,
                  height: 20.h, width: 20.w,
                  color: isAvailable ? Colors.white : Colors.grey,
                ),
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
                      color: isAvailable ? Colors.white : Colors.grey,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      text: subtitle,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6B7280),
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
}