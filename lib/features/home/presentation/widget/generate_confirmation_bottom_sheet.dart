import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ── Color tokens ─────────────────────────────────────────
const _kBg            = Color(0xFF10151B);
const _kCardBg        = Color(0xFF161C24);
const _kCardBorder    = Color(0xFF252B35);
const _kGreen         = Color(0xFF3DDC84);
const _kIconBg        = Color(0xFF1A3528);
const _kSelectedBg    = Color(0xFF0F1F18);
const _kSelectedBorder= Color(0xFF3DDC84);
const _kMuted         = Color(0xFF8E95A2);
const _kCancelBorder  = Color(0xFF2A333D);
const _kCancelBg      = Color(0xFF161C24);

// ── Options model ─────────────────────────────────────────
class _TrainingOption {
  final String title;
  final String subtitle;
  const _TrainingOption({required this.title, required this.subtitle});
}

const _options = [
  _TrainingOption(
    title: 'Entrenamiento rápido (IA)',
    subtitle: 'Sesión corta generada a partir de tus preferencias',
  ),
  _TrainingOption(
    title: 'Registrar entrenamiento',
    subtitle: 'Guarda un entrenamiento manual con ejercicios, series, repeticiones y peso',
  ),
];

// ── Provider ──────────────────────────────────────────────
final _selectedTrainingProvider = StateProvider<int>((ref) => 0);

// ── Widget ────────────────────────────────────────────────
class GenerateConfirmationBottomSheet extends ConsumerWidget {
  const GenerateConfirmationBottomSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      barrierColor: Colors.black54,
      builder: (_) => const ProviderScope(
        child: GenerateConfirmationBottomSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_selectedTrainingProvider);

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

            SizedBox(height: 22.h),

            // ── Title ────────────────────────────────
            Text(
              'Entrena hoy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 6.h),

            // ── Subtitle ─────────────────────────────
            Text(
              'Elige cómo quieres entrenar en este día de descanso',
              style: TextStyle(
                color: _kMuted,
                fontSize: 13.sp,
                height: 1.4,
              ),
            ),

            SizedBox(height: 20.h),

            // ── Option cards ──────────────────────────
            ...List.generate(_options.length, (i) {
              final isSelected = selected == i;
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: GestureDetector(
                  onTap: () => ref
                      .read(_selectedTrainingProvider.notifier)
                      .state = i,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 14.h),
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
                          color: _kGreen.withValues(alpha: 0.07),
                          blurRadius: 14,
                          spreadRadius: 2,
                        ),
                      ]
                          : null,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Icon box
                        Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: _kIconBg,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Center(
                            child: Icon(
                              i == 0
                                  ? Icons.bolt_rounded
                                  : Icons.fitness_center_rounded,
                              color: _kGreen,
                              size: 20.sp,
                            ),
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Text
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _options[i].title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  height: 1.3,
                                ),
                              ),
                              SizedBox(height: 3.h),
                              Text(
                                _options[i].subtitle,
                                style: TextStyle(
                                  color: _kMuted,
                                  fontSize: 11.sp,
                                  height: 1.4,
                                ),
                              ),
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

            SizedBox(height: 16.h),

            // ── Bottom action row: Cancelar + Comenzar ─
            Row(
              children: [
                // Cancelar — outlined
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: _kCancelBg,
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(
                            color: _kCancelBorder, width: 1.5.w),
                      ),
                      child: Center(
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 12.w),

                // Comenzar — solid green
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      decoration: BoxDecoration(
                        color: _kGreen,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                        child: Text(
                          'Comenzar',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}