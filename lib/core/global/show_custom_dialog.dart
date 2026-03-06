import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_color.dart';
import 'custom_button.dart';
import 'custom_text.dart';

void showCustomDialog(
    BuildContext context, {
      required String imagePath,
      required String title,
      String? message,
      required String buttonText,
      String? secondButtonText,
      void Function()? onPressed,
      void Function()? onSecondPressed,
      bool isDoubleButton = false,
    }) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.r),
        ),
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 30.r, vertical: 20.r),
          decoration: BoxDecoration(
            color: isDarkMode
                ? const Color(0xFF252525)
                : Color(0xFF323437),
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(imagePath, height: 122.h, width: 200.w),

              SizedBox(height: 20.h),

              CustomText(
                text: title,
                textAlign: TextAlign.center,
                fontSize: 28.spMin,
                fontWeight: FontWeight.w600,
                color: isDarkMode
                    ? AppColor.white
                    : AppColor.textBody,
              ),

              if (message != null && message.isNotEmpty) ...[
                SizedBox(height: 10.h),
                CustomText(
                  text: message,
                  textAlign: TextAlign.center,
                  fontSize: 16.spMin,
                  fontWeight: FontWeight.w400,
                  color: isDarkMode
                      ? AppColor.white
                      : AppColor.textBody,
                ),
              ],

              SizedBox(height: 20.h),

              isDoubleButton
                  ? Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      isOutlined: true,
                      textColor: AppColor.primary,
                      text: buttonText,
                      onPressed: onPressed ?? () {},
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: CustomButton(
                      textColor: Colors.white,
                      text: secondButtonText ?? 'Cancel',
                      onPressed: onSecondPressed ??
                              () => Navigator.pop(context),
                    ),
                  ),
                ],
              )
                  : CustomButton(
                text: buttonText,
                textColor: Colors.white,
                onPressed: onPressed ?? () {},
              ),
            ],
          ),
        ),
      );
    },
  );
}