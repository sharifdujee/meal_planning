import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/registration/provider/workout_log_provider.dart';

class SeassionTimeCard extends ConsumerWidget{
  const SeassionTimeCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log = ref.watch(workoutLogProvider);
    final notifier = ref.read(workoutLogProvider.notifier);

    //format Duration
    String formatDuration(Duration duration){
      String twoDigits(int n) => n.toString().padLeft(2,'0');
      String twoDigitsMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitsSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)} : $twoDigitsMinutes : $twoDigitsSeconds";
    }
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Color(0xFF202122),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(width: 1, color: Color(0xFF383A42)),
        boxShadow: [
          BoxShadow(
            color: Color(0XFF000000).withValues(alpha: 0.15),
            blurRadius: 7,
            spreadRadius: 1
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Temporizador de sesión",
            color: Colors.white,
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          SizedBox(height: 40.h,),
          Container(
            alignment: Alignment.center,
            child: CustomText(
              text: formatDuration(log.sessionTime),
              fontWeight: FontWeight.w600,
              color: Colors.white,
              fontSize: 40.sp,
            ),
          ),
          SizedBox(height: 40.h,),
          if (!log.isTimerRunning && log.sessionTime == Duration.zero)
          CustomButton(
            prefixIcon: Icons.play_arrow_outlined,
            text: "Iniciar entrenamiento",
            onPressed: (){
              notifier.startTimer();
            },
          )
          else
           Column(
             children: [
               Row(
                 children: [
                   Expanded(
                     child: OutlinedButton.icon(
                       onPressed: ()=>log.isTimerRunning
                       ? notifier.pauseTimer(): notifier.startTimer(),
                       icon: Icon(
                         log.isTimerRunning ? Icons.pause_rounded : Icons.play_arrow_outlined,
                       ),
                       label: CustomText(
                         text: log.isTimerRunning ? "Pausa" : "Reanudar",
                         color: Colors.white,
                       ),
                     ),
                   )
                 ],
               )
             ],
           )
        ],
      ),
    );
  }
}