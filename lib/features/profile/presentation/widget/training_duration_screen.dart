

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/global/show_custom_dialog.dart';
import 'package:meal_planning/core/design_system/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

final selectedBreakProvider = StateProvider<Duration>((ref) => const Duration(seconds: 30));
final customBreakTimesProvider = StateProvider<List<Duration>>((ref) => []);

String formatDuration(Duration d) {
  return '${d.inMinutes} min';
}

class TrainingDurationScreen extends ConsumerWidget {
  const TrainingDurationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedBreakProvider);
    final customs = ref.watch(customBreakTimesProvider);

    final presets = [
      const Duration(minutes: 15),
      const Duration(minutes: 30),
      const Duration(minutes: 45),
      const Duration(minutes: 60),
      const Duration(minutes: 75),
      const Duration(minutes: 90),
      const Duration(minutes: 105),
      const Duration(minutes: 120),
    ];

    final allOptions = [...presets, ...customs];

    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Duración del entrenamiento',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 3.0,
                      ),
                      itemCount: allOptions.length,
                      itemBuilder: (context, i) {
                        final dur = allOptions[i];
                        final isSelected = dur == selected;
                        final isCustom = !presets.any((p) => p.inSeconds == dur.inSeconds);

                        return GestureDetector(
                          onTap: () {
                            ref.read(selectedBreakProvider.notifier).state = dur;
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 160),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C1C1E),
                              borderRadius: BorderRadius.circular(14),
                              border: isSelected
                                  ? Border.all(color: AppColor.primary, width: 2)
                                  : null,
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Main content: label + custom X
                                Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text:   formatDuration(dur),

                                        color: isSelected ? AppColor.primary : Colors.white,
                                        fontSize: 17.sp,
                                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                        letterSpacing: -0.3,

                                      ),
                                      if (isCustom)
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            ref.read(customBreakTimesProvider.notifier).update((state) {
                                              final newList = [...state]..removeWhere((d) => d.inSeconds == dur.inSeconds);
                                              return newList;
                                            });
                                            if (selected.inSeconds == dur.inSeconds) {
                                              ref.read(selectedBreakProvider.notifier).state = presets.first;
                                            }
                                          },
                                          child:  Container(
                                            margin: EdgeInsets.all(4),
                                            child: Icon(
                                              CupertinoIcons.clear_circled_solid,
                                              size: 20.sp,
                                              color: Color(0xFF8E8E93),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // Radio indicator on RIGHT side
                                Positioned(
                                  right: 16.w,
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected ? AppColor.primary : const Color(0xFF8E8E93),
                                        width: 2,
                                      ),
                                      color: isSelected ? AppColor.primary : Colors.transparent,
                                    ),
                                    alignment: Alignment.center,
                                    child: isSelected
                                        ? const Icon(
                                      CupertinoIcons.check_mark,
                                      color: Colors.white,
                                      size: 16,
                                    )
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 28),
                    Container(
                      margin: EdgeInsets.only(left: 210.w),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1.w,
                          color: Color(0xFF6BC799)
                        ),
                        borderRadius: BorderRadius.circular(40.r),
                        
                      ),
                      child: CupertinoButton(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),



                        child:  CustomText(
                          text:  '+ Añadir más',

                          color: AppColor.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,

                        ),
                        onPressed: () async {
                          final picked = await showCupertinoModalPopup<Duration?>(
                            context: context,
                            builder: (_) => const _DurationPicker(),
                          );
                          if (picked != null && picked.inSeconds > 0) {
                            ref.read(customBreakTimesProvider.notifier).update((state) {
                              final exists = state.any((d) => d.inSeconds == picked.inSeconds);
                              if (exists) return state;
                              return [...state, picked]..sort((a, b) => a.inSeconds.compareTo(b.inSeconds));
                            });
                            ref.read(selectedBreakProvider.notifier).state = picked;
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomButton(text: "Guardar", onPressed: (){
                showCustomDialog(context, imagePath: IconPath.success, title: "Confirmación", buttonText: "Hecho", message: "Tu duración de entrenamiento se ha añadido correctamente a la lista", onPressed: (){
                  context.pop();
                });

              }),
            )
          ],
        ),
      ),
    );
  }
}

// _DurationPicker remains unchanged
class _DurationPicker extends StatefulWidget {
  const _DurationPicker();
  @override
  State<_DurationPicker> createState() => _DurationPickerState();
}

class _DurationPickerState extends State<_DurationPicker> {
  int hour = 0;
  int minute = 15;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      color: const Color(0xFF1C1C1E),
      child: Column(
        children: [
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('hour', style: TextStyle(color: Colors.white70, fontSize: 15)),
              SizedBox(width: 90),
              Text('min', style: TextStyle(color: Colors.white70, fontSize: 15)),
            ],
          ),

          Expanded(
            child: Row(
              children: [
                /// Hour picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 44,
                    magnification: 1.22,
                    useMagnifier: true,
                    onSelectedItemChanged: (v) => setState(() => hour = v),
                    children: List.generate(
                      6,
                          (i) => Center(
                        child: Text(
                          '$i',
                          style: const TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),

                /// Minute picker
                Expanded(
                  child: CupertinoPicker(
                    itemExtent: 44,
                    magnification: 1.22,
                    useMagnifier: true,
                    onSelectedItemChanged: (v) => setState(() => minute = v * 5),
                    children: List.generate(
                      12,
                          (i) => Center(
                        child: Text(
                          '${i * 5}',
                          style: const TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                  child: const Text(
                    'Cancelar',
                    style: TextStyle(color: CupertinoColors.systemRed, fontSize: 17),
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                CupertinoButton(
                  child: const Text(
                    'Aceptar',
                    style: TextStyle(
                      color: Color(0xFF34C759),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    final dur = Duration(hours: hour, minutes: minute);
                    Navigator.pop(context, dur.inMinutes > 0 ? dur : null);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}