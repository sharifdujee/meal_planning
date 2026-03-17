import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterToggle<T> extends StatelessWidget {
  final List<T> values;
  final T selectedValue;
  final Function(T) onSelected;
  final String Function(T) labelBuilder;

  const FilterToggle({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.onSelected,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: values.map((val) {
          bool isSelected = val == selectedValue;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelected(val),
              child: Container(
                margin: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF469271) : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  labelBuilder(val).toUpperCase(),
                  style: TextStyle(
                    color: isSelected ? Colors.black : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}