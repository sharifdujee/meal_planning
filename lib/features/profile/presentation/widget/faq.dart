import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/app_color.dart';


// ── Model ─────────────────────────────────────────────────────────────────────

class _FaqSection {
  final String question;
  final List<_FaqContent> content;
  const _FaqSection({required this.question, required this.content});
}

abstract class _FaqContent {}

class _FaqText extends _FaqContent {
  final String text;
  final bool isBold;
  final bool isSmall;
  _FaqText(this.text, {this.isBold = false, this.isSmall = false});
}

class _FaqPlanCard extends _FaqContent {
  final IconData icon;
  final String title;
  final String subtitle;
  _FaqPlanCard({required this.icon, required this.title, required this.subtitle});
}

class _FaqNumberedItem extends _FaqContent {
  final int number;
  final String text;
  _FaqNumberedItem({required this.number, required this.text});
}

class _FaqSubheading extends _FaqContent {
  final String text;
  _FaqSubheading(this.text);
}

// ── Data ──────────────────────────────────────────────────────────────────────

final List<_FaqSection> _faqs = [
  _FaqSection(
    question: '¿CÓMO FUNCIONA LA SUSCRIPCIÓN?',
    content: [
      _FaqText('Ofrecemos dos tipos de suscripciones para cambiar tu vida'),
      _FaqPlanCard(
        icon: Icons.emoji_events_outlined,
        title: 'Tu Ranking (Mensual)',
        subtitle: 'Clasificación (3,49 €/mes. Acceso completo a la clasificación)',
      ),
      _FaqPlanCard(
        icon: Icons.workspace_premium_outlined,
        title: 'Imperfecto Pro (Mensual)',
        subtitle: 'Imperfecto Pro (9,99 €/mes. Acceso completo a imperfecto pro)',
      ),
      _FaqText(
        'Los planes incluyen todas las funciones premium: planes de entrenamiento personalizados, planificación de IA, lista de compras automática, seguimiento del progreso y más.',
        isSmall: true,
      ),
    ],
  ),
  _FaqSection(
    question: '¿CÓMO PUEDO CANCELAR MI SUSCRIPCIÓN?',
    content: [
      _FaqText('Cancelar es fácil y sin compromiso:'),
      _FaqSubheading('En iOS (App Store):'),
      _FaqNumberedItem(number: 1, text: 'Abre Configuración en tu iPhone'),
      _FaqNumberedItem(number: 2, text: 'Toca tu nombre (ID de Apple)'),
      _FaqNumberedItem(number: 3, text: 'Selecciona "Suscripciones"'),
      _FaqNumberedItem(number: 4, text: 'Busca Imperfecto y toca "Cancelar Suscripción"'),
      _FaqSubheading('En Android (Google Play):'),
      _FaqNumberedItem(number: 1, text: 'Abre Google Play Store'),
      _FaqNumberedItem(number: 2, text: 'Toca tu perfil > Pagos y suscripciones'),
      _FaqNumberedItem(number: 3, text: 'Selecciona "Suscripciones"'),
      _FaqNumberedItem(number: 4, text: 'Busca Imperfecto y toca "Cancelar Suscripción"'),
    ],
  ),
  _FaqSection(
    question: '¿PUEDO USAR LA APP SIN SUSCRIPCIÓN?',
    content: [
      _FaqText(
        'Sí, puedes acceder a funciones básicas de forma gratuita. Con la suscripción desbloqueas todo el potencial de la app: planes personalizados, IA avanzada y seguimiento completo.',
      ),
    ],
  ),
  _FaqSection(
    question: '¿MIS DATOS ESTÁN SEGUROS?',
    content: [
      _FaqText(
        'Protegemos tus datos con encriptación de extremo a extremo. Nunca vendemos tu información personal a terceros. Puedes consultar nuestra Política de Privacidad para más detalles.',
      ),
    ],
  ),
  _FaqSection(
    question: '¿CÓMO FUNCIONA LA IA DE PLANIFICACIÓN?',
    content: [
      _FaqText(
        'Nuestra IA analiza tus objetivos, nivel de actividad, preferencias alimentarias e historial de progreso para generar planes completamente personalizados que se adaptan a ti cada semana.',
      ),
    ],
  ),
  _FaqSection(
    question: '¿PUEDO CAMBIAR MI PLAN DE ENTRENAMIENTO?',
    content: [
      _FaqText(
        'Sí, puedes actualizar tus objetivos y preferencias en cualquier momento desde tu perfil. La IA regenerará automáticamente un nuevo plan adaptado a tus nuevas metas.',
      ),
    ],
  ),
];

// ── Colors ────────────────────────────────────────────────────────────────────

class _C {






  static const planBorder = Color(0xFF2E3038);
  static const subheading = Color(0xFFCCCCCC);
}

// ── Screen ────────────────────────────────────────────────────────────────────

class FrequentlyAskingQuestion extends StatelessWidget {
  const FrequentlyAskingQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bg,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF469271).withValues(alpha: 0.15),
              AppColor.bg,
            ],
            stops: const [0.0, 0.07],
          ),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            children: [
              SizedBox(height: 54.h),

              // ── AppBar ──────────────────────────────────────────────
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
                    SizedBox(width: 14.w),
                    Text(
                      'Preguntas Frecuentes',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColor.white,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // ── FAQ list ────────────────────────────────────────────
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 40.h),
                  itemCount: _faqs.length,
                  itemBuilder: (_, i) => _FaqBlock(section: _faqs[i]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── FAQ Block ─────────────────────────────────────────────────────────────────

class _FaqBlock extends StatelessWidget {
  final _FaqSection section;
  const _FaqBlock({required this.section});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question heading
          Text(
            section.question,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
              color: AppColor.white,
              height: 1.4,
            ),
          ),
          SizedBox(height: 12.h),

          // Content items
          ...section.content.map((item) {
            if (item is _FaqText) return _TextItem(item: item);
            if (item is _FaqPlanCard) return _PlanCardItem(item: item);
            if (item is _FaqNumberedItem) return _NumberedItem(item: item);
            if (item is _FaqSubheading) return _SubheadingItem(item: item);
            return const SizedBox.shrink();
          }),
        ],
      ),
    );
  }
}

// ── Content item widgets ──────────────────────────────────────────────────────

class _TextItem extends StatelessWidget {
  final _FaqText item;
  const _TextItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Text(
        item.text,
        style: TextStyle(
          fontSize: item.isSmall ? 13.sp : 14.sp,
          fontWeight: item.isBold ? FontWeight.w600 : FontWeight.w400,
          color: item.isBold ? AppColor.white : AppColor.textBody,
          height: 1.55,
        ),
      ),
    );
  }
}

class _PlanCardItem extends StatelessWidget {
  final _FaqPlanCard item;
  const _PlanCardItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      padding: EdgeInsets.fromLTRB(14.w, 12.h, 14.w, 12.h),
      decoration: BoxDecoration(
        color: AppColor.planCard,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: _C.planBorder, width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.h,
            decoration: BoxDecoration(
              color: AppColor.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(item.icon, color: AppColor.primary, size: 17.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColor.textBody,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SubheadingItem extends StatelessWidget {
  final _FaqSubheading item;
  const _SubheadingItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6.h, bottom: 6.h),
      child: Text(
        item.text,
        style: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: _C.subheading,
          height: 1.4,
        ),
      ),
    );
  }
}

class _NumberedItem extends StatelessWidget {
  final _FaqNumberedItem item;
  const _NumberedItem({required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
          text:   '${item.number}. ',

              fontSize: 13.sp,
              color: AppColor.textBody,
              height: 1.55,

          ),
          Expanded(
            child: CustomText(
             text:  item.text,

                fontSize: 13.sp,
                color: AppColor.textBody,
                height: 1.55,

            ),
          ),
        ],
      ),
    );
  }
}