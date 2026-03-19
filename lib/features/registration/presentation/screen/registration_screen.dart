import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/global/custom_text_form_field.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/registration/provider/workout_log_provider.dart';
import 'package:meal_planning/features/registration/widget/date_picker_field.dart';

import '../../widget/classification_progress_card.dart';
import '../../widget/exercise_section.dart';
import '../../widget/seassion_time_card.dart';

class RegistrationScreen extends ConsumerStatefulWidget {
  const RegistrationScreen({super.key});

  @override
  ConsumerState<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends ConsumerState<RegistrationScreen> {

  @override
  void initState() {
    super.initState();
    // You can perform initialization logic here using ref.read() if needed
  }

  @override
  Widget build(BuildContext context) {
    // In ConsumerState, 'ref' is a property of the class, so no need to pass it to build
    final log = ref.watch(workoutLogProvider);
    final notifier = ref.read(workoutLogProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF469271).withValues(alpha: 0.2),
                const Color(0xFF0E1115),
              ],
              stops: const [0.0, 0.05],
            ),
          ),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Image.asset(
                        IconPath.arrowLeft,
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 52.h),
                      child: CustomText(
                        text: "Registrar entrenamiento",
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(height: 48, width: 48)
                  ],
                ),

                CustomText(
                  text: "Nombre del entrenamiento",
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
                SizedBox(height: 10.h),
                CustomTextFormField(
                  controller: notifier.workoutNameController,
                  hintText: "Ej: Pecho y tríceps",
                  hintTextColor: const Color(0xFF5B616E),
                  hintTextSize: 14.sp,
                  containerColor: const Color(0xFF202122),
                ),
                SizedBox(height: 24.h),
                CustomText(
                  text: "Fecha",
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 10.h),
                const DatePickerField(),
                SizedBox(height: 24.h),
                const SeassionTimeCard(),
                SizedBox(height: 24.h),

                // Active based on notifier
                if (log.isActiveClassificationProgressCard) ...[
                  const ClassificationProgressCard(),
                  SizedBox(height: 24.h),
                ],

                CustomText(
                  text: "Notas (Opcional)",
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                SizedBox(height: 12.h),
                CustomTextFormField(
                  controller: notifier.notesController,
                  hintText: "Añade cualquier observación...",
                  hintTextColor: const Color(0xFF5B616E),
                  containerColor: const Color(0xFF202122),
                  maxLines: 5,
                ),
                SizedBox(height: 24.h),
                const ExerciseSection(),
                SizedBox(height: 32.h)
              ],
            ),
          ),
        ),
      ),
    );
  }
}