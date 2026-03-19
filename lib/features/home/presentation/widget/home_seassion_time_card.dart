import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../../provider/seassion _time_card_provider.dart';

class HomeSeassionTimeCard extends ConsumerWidget {
  const HomeSeassionTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use the variable name of the provider, not the class name
    final log = ref.watch(seassionWorkoutLogProvider);
    final notifier = ref.read(seassionWorkoutLogProvider.notifier);

    String formatDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, '0');
      String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)} : $twoDigitsMinutes : $twoDigitsSeconds";
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
          color: const Color(0xFF202122),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(width: 1, color: const Color(0xFF383A42)),
          boxShadow: [
            BoxShadow(
                color: const Color(0XFF000000).withValues(alpha: 0.15),
                blurRadius: 7,
                spreadRadius: 1)
          ]),
      child: Column(
        mainAxisSize: MainAxisSize.min, // Correctly manage vertical space
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Tu tarea hoy",
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 40.h),
          Container(
            alignment: Alignment.center,
            child: CustomText(
              text: formatDuration(log.sessionTime),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 40.sp,
            ),
          ),
          if (log.isFinished) ...[
            SizedBox(height: 12.h),
            Center(
              child: CustomText(
                text: "Sesión finalizada",
                color: const Color(0xFF6B7280),
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          SizedBox(height: 40.h),

          /* --- DYNAMIC BUTTON LOGIC --- */

          if (log.isFinished)
          // STATE: FINISHED -> Full Width Reiniciar
            _buildCustomButton(
              text: "Reiniciar",
              buttonIcon: IconPath.redo,
              onTap: () => notifier.rebootTimer(),
              isFullWidth: true,
              textColor: Colors.white,
            )
          else if (!log.isTimerRunning && log.sessionTime == Duration.zero)
          // STATE: INITIAL -> Full Width Iniciar
            _buildCustomButton(
              text: "Iniciar entrenamiento",
              buttonIcon: IconPath.vector,
              onTap: () => notifier.startTimer(),
              isFullWidth: true,
              textColor: Colors.white,
              isTransparent: false
            )
          else
          // STATE: RUNNING/PAUSED -> Two side-by-side buttons
            Row(
              children: [
                Expanded(
                  child: _buildCustomButton(
                    text: log.isTimerRunning ? "Pausa" : "Reanudar",

                    buttonIcon: log.isTimerRunning ? IconPath.pause : IconPath.vector,
                    onTap: () => log.isTimerRunning ? notifier.pauseTimer() : notifier.startTimer(),
                    textColor: Colors.white,
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: _buildCustomButton(
                    text: "Finalizar",
                    onTap: () => notifier.finishWorkout(),
                    textColor: const Color(0xFF38755A),
                    buttonIcon: IconPath.stop
                  ),
                ),
              ],
            ),

          //SizedBox(height: 12.h),
        ],
      ),
    );
  }

  /// Helper to build the design-specific GestureDetector button
  Widget _buildCustomButton({
    required String text,
    required VoidCallback onTap,
    required Color textColor,
    bool isFullWidth = false,
    bool isTransparent =true,
    required String buttonIcon,
  }) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(99.r),
            color: isTransparent ? Colors.transparent : Color(0xFF469271),
            border: Border.all(
              width: 1,
              color: const Color(0xFF469271),
            ),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(buttonIcon,height:  24.h,width: 24.w,),
              SizedBox(width: 8.w),
              CustomText(
                text: text,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}