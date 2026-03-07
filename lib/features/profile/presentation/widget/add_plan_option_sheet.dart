import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../screen/profile_screen.dart';
import 'import_pdf_sheet.dart';
import 'option_tile.dart';

class AddPlanOptionsSheet extends StatelessWidget {
  const AddPlanOptionsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF1A1F24),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 36.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // drag handle
          Center(
            child: Container(
              width: 36.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          // Title row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Añadir mi plan',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.3,
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.close_rounded,
                      color: Colors.white.withValues(alpha: 0.6), size: 16.r),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Escribir Plan
          OptionTile(
            icon: Icons.edit_outlined,
            label: 'Escribir Plan',
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => const WritePlanSheet(),
              );
            },
          ),
          SizedBox(height: 10.h),

          // Adjuntar Documento
          OptionTile(
            icon: Icons.attach_file_rounded,
            label: 'Adjuntar Documento',
            onTap: () {
              Navigator.pop(context);
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => const ImportPDFSheet(),
              );
            },
          ),
        ],
      ),
    );
  }
}