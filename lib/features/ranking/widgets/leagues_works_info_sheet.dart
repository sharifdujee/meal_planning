import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/design_system/app_color.dart';
import 'package:meal_planning/core/global/custom_button.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

class LeaguesWorksInfoSheet extends ConsumerWidget {
  const LeaguesWorksInfoSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: const Color(0xFF10151B),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(32),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.9,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handler
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
              width: 70.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.r),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6BC799),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Image.asset(
                            IconPath.champion,
                            height: 20.h,
                            width: 20.w,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          text: "¿Cómo funcionan las ligas?",
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h,),
                    CustomText(
                      text: "🏆 Cómo se calculan los 18 puntos diarios",
                      fontSize: 18.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 16.h,),
                    CustomText(
                      text:"🔁 Finalización de sesión — 6 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- Comenzar entrenamiento → 2 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- Terminar rutina completa planificada → 4 pts ",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    SizedBox(height: 10.h,),
                    CustomText(
                      text:"🎯 Tiempo real de entrenamiento — 6 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- 35 minutos → 2 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- 45 minutos → 4 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- 60 minutos → 6 pts (máx)",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    SizedBox(height: 10.h,),
                    CustomText(
                      text:"✅ Calidad y consistencia — 6 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"- +1 si registras ≥70% series",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),CustomText(
                      text:"- +2 si ≥85%",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),CustomText(
                      fontSize: 14.sp,
                      text:"- +3 si 100%",
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    SizedBox( height: 10.h,),
                    CustomText(
                      text:"🔥 Máximo diario: 18 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text:"     Máximo semanal: 126 pts",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),

                    SizedBox(height: 24.h),
                    CustomText(
                      text: "🏆 Reglas de la Liga Semanal",
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                    text: "🔁 Nueva liga cada lunes fontSize",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "Compite semanalmente contra 20 jugadores de tu nivel de habilidad.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "🎯 Tu rango depende de los puntos totales ganados por entrenamiento durante la semana.d.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "✅ Máximo posible: 126 puntos (18 pts × 7 días)",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "❌ No hay bonificaciones ni puntos extra en las ligas.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "🔥 ¡Gana entrenando más días y de manera más consistente!",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),

                    SizedBox(height: 24.h),
                    CustomText(
                      text: "📊 Resultados de Fin de Semana",
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 16.h,),
                    CustomText(
                      text: "⬆️ Top 5 → Ascienden a la siguiente liga",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "🟡 Rangos 6–15 → Permanecen en la misma liga",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "⬇️ Últimos 5 → Descienden a una liga inferior",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),

                    SizedBox(height: 24.h),
                    CustomText(
                      text: "⚖️ Reglas de Desempate",
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 16.h,),
                    CustomText(
                      text: "Si dos o más usuarios tienen los mismos puntos totales, se ordenarán según el siguiente orden de prioridad:",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "1.	📅 Días entrenados (esta semana)",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "El usuario con más días entrenados queda por encima.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "2.	⏱️ Tiempo total de entrenamiento (esta semana)",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "El usuario con más minutos acumulados queda por encima.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "3.	🔥 Racha activa",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "El usuario con la racha actual más larga queda por encima.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "4.	🕒 Sesión más reciente",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "El usuario que haya entrenado más recientemente queda por encima.",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),

                    SizedBox(height: 24.h),
                    CustomText(
                      text: "🎁 Recompensas por Ascenso",
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 16.h,),

                    CustomText(
                      text: "Ascender en una liga desbloquea:",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "✨ Nuevas divisiones y prestigio",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "🎖️ Insignias mensuales y anuales",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    CustomText(
                      text: "🔓 Desafíos y recompensas futuras",
                      fontSize :14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColor.textBody,
                    ),
                    SizedBox(height: 16.h,),
                    CustomButton(
                        text: "Entendido",
                        onPressed: (){
                            Navigator.pop(context);
                        }
                    ),
                    SizedBox(height: 24.h,)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}