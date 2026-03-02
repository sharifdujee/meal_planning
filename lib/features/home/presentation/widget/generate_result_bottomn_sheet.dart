import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/features/home/presentation/widget/generate_confirmation_bottom_sheet.dart';



// ── Color tokens ─────────────────────────────────────────
const _kBg            = Color(0xFF10151B);
const _kCardBg        = Color(0xFF161C24);
const _kCardBorder    = Color(0xFF252B35);
const _kGreen         = Color(0xFF3DDC84);
const _kIconBg        = Color(0xFF3DBD7A);
const _kSelectedBg    = Color(0xFF0F1F18);
const _kSelectedBorder= Color(0xFF3DDC84);
const _kLabelMuted    = Color(0xFF6B7280);
const _kMuted         = Color(0xFF8E95A2);
const _kBtnBorder     = Color(0xFF2A333D);
const _kBadgeBg       = Color(0xFF1A3528);
const _kBadgeBorder   = Color(0xFF2A5040);

// ── Model ─────────────────────────────────────────────────
class AlternativeItem {
  final String title;
  final String description;
  final String? badge; // e.g. "Sin Cocolón"

  const AlternativeItem({
    required this.title,
    required this.description,
    this.badge,
  });
}

// ── Static data ───────────────────────────────────────────
const _alternatives = [
  AlternativeItem(
    title: 'Pollo Zeus a la parrilla',
    description:
    'Una comida de inspiración mediterránea, rica en proteínas magras, grasas saludables y fibra.',
  ),
  AlternativeItem(
    title: 'Filete de coliflor asado',
    description:
    'Una alternativa sustanciosa al bistec de origen vegetal, con carbohidratos complejos que te mantienen satisfecho por más tiempo.',
  ),
  AlternativeItem(
    title: 'Ensalada de atún picante',
    description:
    'Un almuerzo vibrante y energizante con sabores de tuna y cítricos, rico en omega-3.',
    badge: 'Sin Cocolón',
  ),
];

// ── Provider ──────────────────────────────────────────────
final selectedAlternativeProvider = StateProvider<int>((ref) => 0);

// ── Widget ────────────────────────────────────────────────
class GenerateResultBottomSheet extends ConsumerWidget {
  const GenerateResultBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (_) => ProviderScope(
        child: const GenerateResultBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedAlternativeProvider);

    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      child: Container(
        color: _kBg,
        padding: EdgeInsets.only(
          top: 10.h,
          left: 20.w,
          right: 20.w,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Drag handle ──────────────────────────
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              // ── Header: icon + title + subtitle ──────
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 46.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: _kIconBg,
                      borderRadius: BorderRadius.circular(13.r),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.restaurant_rounded,
                        color: Colors.white,
                        size: 21.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 13.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Elige otra opción',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'La misma intención, diferente comida.',
                          style: TextStyle(
                            color: _kMuted,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // ── COMIDA ACTUAL label ───────────────────
              Text(
                'COMIDA ACTUAL',
                style: TextStyle(
                  color: _kLabelMuted,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                ),
              ),

              SizedBox(height: 6.h),

              // ── Current meal name ─────────────────────
              Text(
                'Tazón de Camarones y Quinoa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),

              SizedBox(height: 22.h),

              // ── ALTERNATIVAS INTELIGENTES label ───────
              Text(
                'ALTERNATIVAS INTELIGENTES',
                style: TextStyle(
                  color: _kLabelMuted,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.3,
                ),
              ),

              SizedBox(height: 12.h),

              // ── Alternative cards ─────────────────────
              ...List.generate(_alternatives.length, (i) {
                final isSelected = selected == i;
                return Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: GestureDetector(
                    onTap: () => ref
                        .read(selectedAlternativeProvider.notifier)
                        .state = i,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: isSelected ? _kSelectedBg : _kCardBg,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(
                          color: isSelected
                              ? _kSelectedBorder
                              : _kCardBorder,
                          width: isSelected ? 1.5.w : 1.w,
                        ),
                        boxShadow: isSelected
                            ? [
                          BoxShadow(
                            color: _kGreen.withValues(alpha: 0.08),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                            : null,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text content
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _alternatives[i].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  _alternatives[i].description,
                                  style: TextStyle(
                                    color: _kMuted,
                                    fontSize: 12.sp,
                                    height: 1.45,
                                  ),
                                ),
                                // Badge if present
                                if (_alternatives[i].badge != null) ...[
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.w, vertical: 3.h),
                                    decoration: BoxDecoration(
                                      color: _kBadgeBg,
                                      borderRadius:
                                      BorderRadius.circular(6.r),
                                      border: Border.all(
                                          color: _kBadgeBorder,
                                          width: 1.w),
                                    ),
                                    child: Text(
                                      _alternatives[i].badge!,
                                      style: TextStyle(
                                        color: _kGreen,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),

                          SizedBox(width: 12.w),

                          // Check / empty circle
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 24.w,
                            height: 24.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isSelected
                                  ? Colors.transparent
                                  : Colors.transparent,
                              border: Border.all(
                                color: isSelected
                                    ? _kGreen
                                    : _kCardBorder,
                                width: 1.5.w,
                              ),
                            ),
                            child: isSelected
                                ? Icon(Icons.check_rounded,
                                color: _kGreen, size: 14.sp)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }),

              SizedBox(height: 6.h),

              // ── "Mantén este." outlined button ────────
              SizedBox(
                width: double.infinity,
                child: GestureDetector(
                  onTap: () {
                    showModalBottomSheet(context: context, builder: (context)=>GenerateConfirmationBottomSheet());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                          color: _kBtnBorder, width: 1.5.w),
                    ),
                    child: Center(
                      child: Text(
                        'Mantén este.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}