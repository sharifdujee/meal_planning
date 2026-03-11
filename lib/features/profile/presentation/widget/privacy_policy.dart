import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/features/profile/presentation/widget/section_tile.dart';
import 'package:meal_planning/features/profile/presentation/widget/subtile.dart';

import '../../../../core/design_system/app_color.dart';
import 'body_text.dart';
import 'bullet_item.dart';
class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
                        'Política de Privacidad',
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
                      SectionTitle('INTRODUCCIÓN'),
                      SizedBox(height: 10.h),
                      BodyText(
                        'En Imperfecto, tomamos muy en serio la privacidad de nuestros usuarios. Esta Política de Privacidad explica cómo recopilamos, usamos, almacenamos y protegemos su información personal cuando utiliza nuestra aplicación.',

                      ),

                      SizedBox(height: 24.h),

                      // Section 2
                      SectionTitle('CONTROLADOR DE DATOS'),
                      SizedBox(height: 10.h),
                      SubTitle('Requisitos:'),
                      SizedBox(height: 8.h),
                      BodyText("Individuo en fase de lanzamiento del proyecto"),
                      SizedBox(height: 12.h,),
                      Row(
                        children: [
                          SubTitle("Nombre comercial:"), 
                          SizedBox(width: 4.w,),
                          BodyText("Imperfecto")
                          
                        ],
                      ), 
                      
                      SubTitle("Correo electrónico de contacto:"),
                      SizedBox(height: 8.h,),
                      BodyText("infoimperfecto@gmail.com"),

                      SizedBox(height: 12.h,),
                      Row(
                        children: [
                          SubTitle("País"),
                          SizedBox(width: 4.w,),
                          BodyText("España")

                        ],
                      ),
                      SizedBox(height: 12.h,),

                      SectionTitle("DATOS QUE RECOPILAMOS"),
                      SizedBox(height: 12.h,),
                      SubTitle("Datos de registro:"),

                      BulletItem('Dirección de correo electrónico'),
                      BulletItem('Contraseña (almacenada encriptada)'),
                      SectionTitle("Datos del perfil (opcional):"),
                      SizedBox(height: 12.h,),
                      BulletItem('Edad'),
                      BulletItem('Sexo'),
                      BulletItem('Peso actual y objetivo'),
                      BulletItem('Altura'),
                      BulletItem('Nivel de experiencia'),
                      BulletItem('Preferencias alimenticias e intolerancias'),
                      



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
