import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterToggle<T> extends StatelessWidget {
  final List<T> values;
  final T selectedValue;
  final Function(T) onSelected;
  final String Function(T) labelBuilder;
  // Optional: returns a String path for Image.asset
  final String? Function(T)? iconBuilder;

  const FilterToggle({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.onSelected,
    required this.labelBuilder,
    this.iconBuilder, // Optional parameter
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFF0E1212),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: values.map((val) {
          final bool isSelected = val == selectedValue;
          final String? iconPath = iconBuilder?.call(val);

          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(val),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  gradient: isSelected
                      ? const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF53A37E), Color(0xFF469271)],
                  )
                      : null,
                  color: isSelected ? null : const Color(0xFF161D1D),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (iconPath != null) ...[
                      Image.asset(
                        iconPath,
                        height: 18.h,
                        width: 18.w,
                        // Tint the icon based on selection state
                        color: isSelected ? Colors.white : const Color(0xFF7F8B8B),
                      ),
                      // Only add space if there is also text
                      SizedBox(width: 6.w),
                    ],
                    Text(
                      labelBuilder(val),
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF7F8B8B),
                        fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}