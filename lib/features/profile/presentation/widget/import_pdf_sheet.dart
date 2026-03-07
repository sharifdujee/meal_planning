import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'green_button.dart';
import 'out_line_button.dart';

class ImportPDFSheet extends StatefulWidget {
  const ImportPDFSheet();

  @override
  State<ImportPDFSheet> createState() => _ImportPDFSheetState();
}

class _ImportPDFSheetState extends State<ImportPDFSheet> {
  String? _selectedFileName;

  void _simulateFilePick() {
    // Replace with real file picker (file_picker package)
    setState(() => _selectedFileName = '1 Archivo PDF');
  }

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

          // Title + subtitle
          Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Importar plan (PDF)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.3,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  'Sube tu PDF y aplicaremos tu plan\nautomáticamente',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.45),
                    fontSize: 12.sp,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),

          // File picker area
          GestureDetector(
            onTap: _simulateFilePick,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding:
              EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: _selectedFileName != null
                    ? const Color(0xFF469271).withValues(alpha: 0.08)
                    : const Color(0xFF23292F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _selectedFileName != null
                      ? const Color(0xFF469271).withValues(alpha: 0.4)
                      : Colors.white.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF469271).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.picture_as_pdf_rounded,
                      color: const Color(0xFF469271),
                      size: 16.r,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      _selectedFileName ?? 'Seleccionar archivo PDF',
                      style: TextStyle(
                        color: _selectedFileName != null
                            ? Colors.white
                            : Colors.white.withOpacity(0.4),
                        fontSize: 13.sp,
                        fontWeight: _selectedFileName != null
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                  Icon(
                    _selectedFileName != null
                        ? Icons.check_circle_rounded
                        : Icons.chevron_right_rounded,
                    color: _selectedFileName != null
                        ? const Color(0xFF469271)
                        : Colors.white.withOpacity(0.3),
                    size: 20.r,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: OutlineButton(
                  label: 'Cancelar',
                  onTap: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GreenButton(
                  label: 'Seleccionar PDF',
                  onTap: _selectedFileName != null
                      ? () {
                    // TODO: process PDF
                    Navigator.pop(context);
                  }
                      : _simulateFilePick,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}