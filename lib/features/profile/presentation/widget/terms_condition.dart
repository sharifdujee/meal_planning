import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/features/profile/presentation/widget/section_tile.dart';
import 'package:meal_planning/features/profile/presentation/widget/subtile.dart';

import 'body_text.dart';
import 'bullet_item.dart';

class TermsCondition extends StatelessWidget {
  const TermsCondition({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF469271).withValues(alpha: 0.20),
                  const Color(0xFF0E1115),
                ],
                stops: const [0.0, 0.08],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 58.h),

                // ── Header ──────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColor.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Text(
                        'Términos y Condiciones',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColor.white,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // ── Content ─────────────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section 1
                      SectionTitle('ACEPTACIÓN DE TÉRMINOS'),
                      SizedBox(height: 10.h),
                      BodyText(
                        'Al descargar, instalar o utilizar la aplicación Imperfecto, el usuario acepta estos Términos y Condiciones en su totalidad. Si no está de acuerdo con alguna parte de estos términos, no debe utilizar la aplicación.',
                      ),

                      SizedBox(height: 24.h),

                      // Section 2
                      SectionTitle('DESCRIPCIÓN DEL SERVICIO'),
                      SizedBox(height: 10.h),
                      BodyText('Imperfecto es una aplicación de bienestar que ofrece:'),
                      SizedBox(height: 8.h),
                      BulletItem('Planes de entrenamiento personalizados'),
                      BulletItem('Sugerencias de nutrición adaptadas'),
                      BulletItem('Seguimiento personal del progreso'),
                      BulletItem('Recordatorios y motivación sin presión'),
                      SizedBox(height: 8.h),
                      BodyText(
                        'El servicio está diseñado para acompañar a los usuarios en su camino hacia un estilo de vida más saludable, respetando su ritmo y sin generar culpa.',
                      ),

                      SizedBox(height: 24.h),

                      // Section 3
                      SectionTitle('REGISTRO Y CUENTA'),
                      SizedBox(height: 10.h),
                      SubTitle('Requisitos:'),
                      SizedBox(height: 6.h),
                      BodyText(
                        'Los usuarios deben tener al menos 16 años para crear una cuenta.',
                      ),

                      SizedBox(height: 14.h),

                      SubTitle('Responsabilidad:'),
                      SizedBox(height: 6.h),
                      BodyText(
                        'Los usuarios son responsables de mantener la confidencialidad de sus credenciales de inicio de sesión y de todas las actividades que ocurran bajo su cuenta.',
                      ),

                      SizedBox(height: 24.h),

                      // Section 4
                      SectionTitle('USO ACEPTABLE'),
                      SizedBox(height: 10.h),
                      BodyText('Los usuarios se comprometen a no:'),
                      SizedBox(height: 8.h),
                      BulletItem('Usar la aplicación con fines ilegales o no autorizados'),
                      BulletItem('Intentar acceder a sistemas o redes no autorizados'),
                      BulletItem('Transmitir contenido dañino, ofensivo o inapropiado'),
                      BulletItem('Interferir con el funcionamiento normal de la aplicación'),

                      SizedBox(height: 24.h),

                      // Section 5
                      SectionTitle('PRIVACIDAD Y DATOS'),
                      SizedBox(height: 10.h),
                      BodyText(
                        'La recopilación y uso de datos personales se rige por nuestra Política de Privacidad, que forma parte integral de estos Términos y Condiciones. Al usar la aplicación, el usuario consiente el tratamiento de sus datos conforme a dicha política.',
                      ),

                      SizedBox(height: 24.h),

                      // Section 6
                      SectionTitle('PROPIEDAD INTELECTUAL'),
                      SizedBox(height: 10.h),
                      BodyText(
                        'Todo el contenido de la aplicación, incluyendo pero no limitado a textos, gráficos, logotipos, íconos, imágenes y software, es propiedad de Imperfecto y está protegido por las leyes de propiedad intelectual aplicables.',
                      ),

                      SizedBox(height: 24.h),

                      // Section 7
                      SectionTitle('MODIFICACIONES'),
                      SizedBox(height: 10.h),
                      BodyText(
                        'Imperfecto se reserva el derecho de modificar estos Términos y Condiciones en cualquier momento. Los cambios entrarán en vigor inmediatamente después de su publicación en la aplicación. El uso continuado de la aplicación después de dichos cambios constituye la aceptación de los nuevos términos.',
                      ),

                      SizedBox(height: 40.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





