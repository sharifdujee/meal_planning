import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/design_system/text_style.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:meal_planning/core/global/custom_text_form_field.dart';
import 'package:meal_planning/features/registration/provider/workout_log_provider.dart';
import 'package:meal_planning/features/registration/widget/date_picker_field.dart';

import '../../widget/classification_progress_card.dart';
import '../../widget/exercise_section.dart';
import '../../widget/seassion_time_card.dart';

class RegistrationScreen extends ConsumerWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final log =ref.watch(workoutLogProvider);
    final notifire = ref.read(workoutLogProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          //height: screenHeight*0.3,
          child: Container(
            //Page Design
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF469271).withValues(alpha: 0.2),
                  const Color(0xFF0E1115),
                ],
                stops: const [0.0, 0.05], // green fades out by 35% of screen height
              ),
            ),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Header
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.w,vertical: 52.h),
                    child: CustomText(
                      text: "Registrar entrenamiento",
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),


                  CustomText(
                    text: "Nombre del entrenamiento",
                    fontSize: 14.sp,
                    color: Colors.white,
                  ),
                  SizedBox(height: 10.h,),
                  CustomTextFormField(
                      controller: notifire.workoutNameController,
                    hintText: "Ej: Pecho y tríceps",
                    hintTextColor: Color(0xFF5B616E),
                    hintTextSize: 14.sp,
                    containerColor: Color(0xFF202122),
                  ),
                  SizedBox(height: 24.h,),
                  CustomText(
                    text: "Fecha",
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 10.h,),
                  DatePickerField(),
                  SizedBox(height: 24.h,),
                  SeassionTimeCard(),
                  SizedBox(height: 24.h,),
                  ClassificationProgressCard(),
                  SizedBox(height: 24.h,),
                  CustomText(
                    text: "Notas (Opcional)",
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  SizedBox(height: 12.h,),
                  CustomTextFormField(
                    controller: notifire.notesController,
                    hintText: "Añade cualquier observación...",
                    hintTextColor: Color(0xFF5B616E),
                    containerColor: Color(0xFF202122),
                    maxLines: 5,
                  ),
                  SizedBox(height: 24.h,),
                  ExerciseSection(),
                  SizedBox(height: 32.h,)
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}
