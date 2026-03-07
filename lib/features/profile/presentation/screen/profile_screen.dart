import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/global/show_custom_dialog.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/core/utils/image_path.dart';
import '../../../../core/utils/app_color.dart';
import '../../modal/active_module.dart';
import '../../provider/profile_provider.dart';
import '../widget/add_plan_option_sheet.dart';
import '../widget/menu_item.dart';
import '../widget/menu_tile.dart';
import '../widget/module_tile.dart';
import '../widget/section_card.dart';
import '../widget/subscription_tile.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    final menuItems = [
      MenuItem(icon: IconPath.profileEdit, label: 'Editar perfil', onTap: (){
        context.push("/editProfile");
      }),
      MenuItem(icon: IconPath.vegetable, label: 'Comidas que no me gustan', onTap: (){
        context.push("/foodDontLike");
      }),
      MenuItem(icon: IconPath.alert, label: 'Intolerancias', onTap: (){
        context.push('/IntoleranciasScreen');
      }),
      MenuItem(icon: IconPath.language, label: 'Idioma'),
      MenuItem(icon: IconPath.sleeping, label: 'Tiempo de descanso', onTap: (){
        context.push("/breakTime");
      }),
      MenuItem(icon: IconPath.timer, label: 'Duración del entrenamiento', onTap: (){
        context.push('/trainingDuration');
      }),
      MenuItem(icon: IconPath.calenderThree, label: 'Días de entrenamiento', onTap: (){
        context.push('/daySelection');
      }),
      MenuItem(icon: IconPath.alert, label: 'Mi ejercicio favorito'),
      MenuItem(icon: IconPath.repeat, label: 'Regenerar mi plan', onTap: (){
        context.push("/regenerate");
      }),
      MenuItem(icon: IconPath.terms, label: 'Términos y condiciones', onTap: (){
        context.push("/terms");
      }),
      MenuItem(icon: IconPath.policy, label: 'Política de privacidad', onTap: (){
        context.push('/privacy');
      }),
      MenuItem(icon: IconPath.faq, label: 'Preguntas frecuentes', onTap: (){
        context.push('/faq');
      } ),
      MenuItem(
        icon: IconPath.delete,
        label: 'Eliminar cuenta',
        textColor: AppColor.danger,
          onTap: (){
            showCustomDialog(context, imagePath: IconPath.confirmation, title: "¿Estás Seguro?", buttonText: "Sí, Eliminar", message: "¿Quieres eliminar tu cuenta de forma permanente?", onPressed: (){},
            isDoubleButton: true, secondButtonText: "Cancelar", onSecondPressed: (){});
          }
      ),
      MenuItem(
        icon: IconPath.logOut,
        label: 'Cerrar sesión',
        textColor: AppColor.warning,
          onTap: (){
            showCustomDialog(context, imagePath: IconPath.confirmation, title: "¿Estás Seguro?", buttonText: "Cancelar", message: "¿Quieres cerrar sesión?", onPressed: (){},
                isDoubleButton: true, secondButtonText: "Cerrar sesión", onSecondPressed: (){});
          }
      ),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF469271).withValues(alpha: 0.2),
                  AppColor.background,
                ],
                stops: const [0.0, 0.08],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),

                // ── Title ──────────────────────────────────────────────
                Center(
                  child: Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Avatar ─────────────────────────────────────────────
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColor.cardBackground,
                        child: Image.asset(
                         ImagePath.user
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            // handle avatar upload
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primary,
                            ),
                            child: Image.asset(
                              IconPath.editImage,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Name ───────────────────────────────────────────────
                Center(
                  child: Text(
                    profileState.profile.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Subscription card ──────────────────────────────────
                GestureDetector(
                  onTap: (){
                    context.push("/profileSubscription");
                  },
                  child: SectionCard(
                    child: SubscriptionTile(profile: profileState.profile,),
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Menu items ─────────────────────────────────────────
                SectionCard(
                  child: Column(
                    children: List.generate(menuItems.length, (i) {
                      final item = menuItems[i];
                      final isLast = i == menuItems.length - 1;
                      return MenuTile(
                        item: item,
                        showDivider: !isLast,
                      );
                    }),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Active Modules ─────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Módulos Activos',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBody,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SectionCard(
                  child: Column(
                    children: List.generate(
                      profileState.modules.length,
                          (i) {
                        final module = profileState.modules[i];
                        final isLast = i == profileState.modules.length - 1;
                        return ModuleTile(
                          module: module,
                          showDivider: !isLast,
                          onToggle: () => notifier.toggleModule(i),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Sus datos se conservan incluso si desactiva el módulo',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.textBody,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Custom Plan ────────────────────────────────────────
                SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColor.textBody,
                            size: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Plan Personalizado',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        profileState.hasCustomPlan
                            ? 'Tienes un plan personalizado activo'
                            : 'No tienes un plan personalizado',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.textBody,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: (){
                          _showAddPlanOptions(context);
                        },
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.cardBorder,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColor.white,
                                size: 18.r,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Añadir Mi Plan',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static void _showAddPlanOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const AddPlanOptionsSheet(),
    );
  }
}


















// ── Sheet 2a: Write Plan (Mi rutina semanal) ───────────────────────────────

class WritePlanSheet extends StatefulWidget {
  const WritePlanSheet({super.key});

  @override
  State<WritePlanSheet> createState() => _WritePlanSheetState();
}

class _WritePlanSheetState extends State<WritePlanSheet> {
  final _planNameController = TextEditingController();

  final List<_DayEntry> _days = [
    _DayEntry(day: 'Domingo', type: 'Cuerpo completo'),
    _DayEntry(day: 'Lunes', type: 'Cuerpo completo'),
    _DayEntry(day: 'Martes', type: 'Descanso'),
    _DayEntry(day: 'Miércoles', type: 'Cuerpo completo'),
    _DayEntry(day: 'Jueves', type: 'Descanso'),
    _DayEntry(day: 'Viernes', type: 'Cuerpo completo'),
    _DayEntry(day: 'Sábado', type: 'Descanso'),
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
                    color: Colors.white.withOpacity(0.2),
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
                      color: Colors.white.withOpacity(0.45),
                      fontSize: 12.sp,
                      height: 1.45,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Nombre del plan',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.55),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _InputField(
                    controller: _planNameController,
                    hint: 'Nombre del plan',
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
                itemBuilder: (_, i) => _DayTile(
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
                    child: _OutlineButton(
                      label: 'Cancelar',
                      onTap: () => Navigator.pop(context),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: _GreenButton(
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

// ── Day Tile ───────────────────────────────────────────────────────────────

class _DayEntry {
  final String day;
  final String type;
  final String name;
  final String duration;
  final String notes;

  const _DayEntry({
    required this.day,
    required this.type,
    this.name = '',
    this.duration = '',
    this.notes = '',
  });

  _DayEntry copyWith({
    String? type,
    String? name,
    String? duration,
    String? notes,
  }) =>
      _DayEntry(
        day: day,
        type: type ?? this.type,
        name: name ?? this.name,
        duration: duration ?? this.duration,
        notes: notes ?? this.notes,
      );
}

class _DayTile extends StatelessWidget {
  final _DayEntry entry;
  final bool isExpanded;
  final VoidCallback onToggle;
  final ValueChanged<String> onTypeChanged;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<String> onDurationChanged;
  final ValueChanged<String> onNotesChanged;

  const _DayTile({
    required this.entry,
    required this.isExpanded,
    required this.onToggle,
    required this.onTypeChanged,
    required this.onNameChanged,
    required this.onDurationChanged,
    required this.onNotesChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: const Color(0xFF23292F),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isExpanded
              ? const Color(0xFF469271).withOpacity(0.5)
              : Colors.white.withOpacity(0.06),
        ),
      ),
      child: Column(
        children: [
          // Header row
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 13.h),
              child: Row(
                children: [
                  Container(
                    width: 28.r,
                    height: 28.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF469271).withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.fitness_center_rounded,
                      color: const Color(0xFF469271),
                      size: 14.r,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.day,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          entry.type,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.45),
                            fontSize: 11.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Colors.white.withOpacity(0.4),
                      size: 20.r,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Expanded fields
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 14.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.white.withValues(alpha: 0.07), height: 1),
                  SizedBox(height: 12.h),
                  CustomText(text: 'Nombre del entrenamiento', color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Nombre del entrenamiento',
                    initialValue: entry.name,
                    onChanged: onNameChanged,
                  ),
                  SizedBox(height: 10.h),
                  _FieldLabel('Duración (min)'),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Duración (min)',
                    initialValue: entry.duration,
                    onChanged: onDurationChanged,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10.h),
                  _FieldLabel('Notas'),
                  SizedBox(height: 6.h),
                  _InlineInput(
                    hint: 'Notas adicionales',
                    initialValue: entry.notes,
                    onChanged: onNotesChanged,
                    maxLines: 3,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white.withOpacity(0.5),
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class _InlineInput extends StatelessWidget {
  final String hint;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int maxLines;

  const _InlineInput({
    required this.hint,
    required this.initialValue,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLines: maxLines,
      style: TextStyle(color: Colors.white, fontSize: 13.sp),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        TextStyle(color: Colors.white.withValues(alpha: 0.25), fontSize: 12.sp),
        filled: true,
        fillColor: const Color(0xFF1A1F24),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide:
          const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}

// ── Sheet 2b: Import PDF ───────────────────────────────────────────────────

class _ImportPDFSheet extends StatefulWidget {
  const _ImportPDFSheet();

  @override
  State<_ImportPDFSheet> createState() => _ImportPDFSheetState();
}

class _ImportPDFSheetState extends State<_ImportPDFSheet> {
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
                color: Colors.white.withOpacity(0.2),
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
                    color: Colors.white.withOpacity(0.45),
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
                    ? const Color(0xFF469271).withOpacity(0.08)
                    : const Color(0xFF23292F),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: _selectedFileName != null
                      ? const Color(0xFF469271).withOpacity(0.4)
                      : Colors.white.withOpacity(0.08),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 32.r,
                    height: 32.r,
                    decoration: BoxDecoration(
                      color: const Color(0xFF469271).withOpacity(0.15),
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
                child: _OutlineButton(
                  label: 'Cancelar',
                  onTap: () => Navigator.pop(context),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _GreenButton(
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

// ── Shared input / button widgets ──────────────────────────────────────────

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  const _InputField({required this.controller, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: TextStyle(color: Colors.white, fontSize: 13.sp),
      cursorColor: const Color(0xFF469271),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
        TextStyle(color: Colors.white.withOpacity(0.25), fontSize: 13.sp),
        filled: true,
        fillColor: const Color(0xFF23292F),
        contentPadding:
        EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: Colors.white.withOpacity(0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide:
          const BorderSide(color: Color(0xFF469271), width: 1.5),
        ),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _OutlineButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _GreenButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _GreenButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: const Color(0xFF469271),
          borderRadius: BorderRadius.circular(30.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}



