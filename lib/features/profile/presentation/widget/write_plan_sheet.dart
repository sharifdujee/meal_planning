import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text_form_field.dart';

import 'day_entry.dart';
import 'day_tile.dart';
import 'green_button.dart';
import 'out_line_button.dart';


class WritePlanSheet extends StatefulWidget {
  const WritePlanSheet({super.key});

  @override
  State<WritePlanSheet> createState() => _WritePlanSheetState();
}

class _WritePlanSheetState extends State<WritePlanSheet> {
  final _planNameController = TextEditingController();

  final List<DayEntry> _days = [
    DayEntry(day: 'Domingo', type: 'Cuerpo completo'),
    DayEntry(day: 'Lunes', type: 'Cuerpo completo'),
    DayEntry(day: 'Martes', type: 'Descanso'),
    DayEntry(day: 'Miércoles', type: 'Cuerpo completo'),
    DayEntry(day: 'Jueves', type: 'Descanso'),
    DayEntry(day: 'Viernes', type: 'Cuerpo completo'),
    DayEntry(day: 'Sábado', type: 'Descanso'),
  ];

  int? _expandedIndex;

  @override
  void dispose() {
    _planNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.88,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, scrollController) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1A1F24),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          children: [
            // drag handle
            Padding(
              padding: EdgeInsets.only(top: 12.h),
              child: Center(
                child: Container(
                  width: 36.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Mi rutina semanal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.3,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Define tu plantilla de entrenamiento. El orden de\nlos ejercicios se adapta a tu semana real.',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 12.sp,
                      height: 1.45,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Nombre del plan',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.55),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextFormField(
                    controller: _planNameController,
                    hintText: 'Nombre del plan',
                  ),
                ],
              ),
            ),
            SizedBox(height: 12.h),

            // Day list
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemCount: _days.length,
                separatorBuilder: (_, __) => SizedBox(height: 8.h),
                itemBuilder: (_, i) => DayTile(
                  entry: _days[i],
                  isExpanded: _expandedIndex == i,
                  onToggle: () =>
                      setState(() => _expandedIndex = _expandedIndex == i ? null : i),
                  onTypeChanged: (val) =>
                      setState(() => _days[i] = _days[i].copyWith(type: val)),
                  onNameChanged: (val) =>
                      setState(() => _days[i] = _days[i].copyWith(name: val)),
                  onDurationChanged: (val) =>
                      setState(() => _days[i] = _days[i].copyWith(duration: val)),
                  onNotesChanged: (val) =>
                      setState(() => _days[i] = _days[i].copyWith(notes: val)),
                ),
              ),
            ),

            // Bottom buttons
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 12.h, 20.w, 32.h),
              child: Row(
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
                      label: 'Guardar cambios',
                      onTap: () {
                        // TODO: save logic
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}












