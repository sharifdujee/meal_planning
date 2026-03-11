import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../core/global/custom_button.dart';
import '../../../../core/design_system/app_color.dart';

class ImportPDFSheet extends StatefulWidget {
  const ImportPDFSheet();

  @override
  State<ImportPDFSheet> createState() => ImportPDFSheetState();
}

class ImportPDFSheetState extends State<ImportPDFSheet> {
  String? _selectedFileName;
  File? _selectedFile;
  bool _showViewer = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _selectedFileName = result.files.single.name;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── PDF Viewer fullscreen ──────────────────────────────────────
    if (_showViewer && _selectedFile != null) {
      return Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1F24),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // Top bar
            SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _showViewer = false),
                      child: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 18.r,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _selectedFileName ?? 'PDF',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // TODO: pass _selectedFile up for processing
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 14.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFF469271),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          'Usar este',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // PDF Viewer
            Expanded(
              child: SfPdfViewer.file(
                _selectedFile!,
                pageLayoutMode: PdfPageLayoutMode.continuous,
                scrollDirection: PdfScrollDirection.vertical,
                canShowScrollHead: true,
                canShowScrollStatus: true,
              ),
            ),
          ],
        ),
      );
    }

    // ── File picker UI ─────────────────────────────────────────────
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
            onTap: _pickFile,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 160),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                            : Colors.white.withValues(alpha: 0.4),
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
                        : Colors.white.withValues(alpha: 0.3),
                    size: 20.r,
                  ),
                ],
              ),
            ),
          ),

          // Preview button (shows only after file is picked)
          if (_selectedFile != null) ...[
            SizedBox(height: 12.h),
            GestureDetector(
              onTap: () => setState(() => _showViewer = true),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.visibility_rounded,
                        color: Colors.white.withValues(alpha: 0.6),
                        size: 16.r),
                    SizedBox(width: 6.w),
                    Text(
                      'Vista previa del PDF',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          SizedBox(height: 24.h),

          // Buttons
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  text: 'Cancelar',
                  isOutlined: true,
                  textColor: AppColor.primary,
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomButton(
                  text: _selectedFile != null
                      ? 'Usar este PDF'
                      : 'Seleccionar PDF',
                  onPressed: () {
                    if (_selectedFile != null) {
                      // TODO: pass _selectedFile to your processing logic
                      Navigator.pop(context);
                    } else {
                      _pickFile();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}