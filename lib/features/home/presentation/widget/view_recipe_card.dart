import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';



// ── Color tokens ────────────────────────────────────────────
const _kBg         = Color(0xFF0E1115);
const _kGreen      = Color(0xFF3DDC84);
const _kIconBg     = Color(0xFF2A5C45);
const _kChipBg     = Color(0xFF1A2E22);
const _kDivider    = Color(0xFF1E2530);
const _kMuted      = Color(0xFF8E95A2);
const _kWhite      = Colors.white;
const _kStepBg     = Color(0xFF161C24);
const _kStepBorder = Color(0xFF252B35);

// ── Data models ─────────────────────────────────────────────
class _Ingredient {
  final String name;
  final String amount;
  final bool isGreen; // green colored amount
  const _Ingredient(this.name, this.amount, {this.isGreen = false});
}

class _Step {
  final int number;
  final String text;
  const _Step(this.number, this.text);
}

// ── Static data ──────────────────────────────────────────────
const _ingredients = [
  _Ingredient('Camarones Cocidos', '120 g'),
  _Ingredient('Quinoa Seca (Cocida)', '200 g'),
  _Ingredient('Guisantes Azules', '100 g'),
  _Ingredient('Zanahorias Ralladas', '100 g'),
  _Ingredient('Aceite de Sésamo', '1 cucharadita', isGreen: true),
  _Ingredient('Vinagre de Arroz', '1 cucharadita', isGreen: true),
  _Ingredient('Pechuga de Pollo', '120 g'),
];

const _steps = [
  _Step(1, 'Cocina la quinoa según las instrucciones.'),
  _Step(2,
      'Combina la quinoa, los camarones cocidos, los guisantes azules y las zanahorias ralladas en un bol.'),
  _Step(3, 'Rocía con vinagre de arroz.'),
];

// ── Widget ───────────────────────────────────────────────────
class ViewRecipeCard extends StatelessWidget {
  const ViewRecipeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
      child: Container(
        color: _kBg,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 32.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Drag handle ───────────────────────────
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 12.h, bottom: 20.h),
                  child: Container(
                    width: 44.w,
                    height: 4.5.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.22),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Header row ─────────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Green icon square
                        Container(
                          width: 44.w,
                          height: 44.h,
                          decoration: BoxDecoration(
                            color: _kIconBg,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.restaurant_rounded,
                              color: _kGreen,
                              size: 20.sp,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ALMUERZO',
                              style: TextStyle(
                                color: _kGreen,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.1,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              'Camarones y Quinoa',
                              style: TextStyle(
                                color: _kWhite,
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w700,
                                height: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    // ── Description ────────────────────
                    Text(
                      'Una comida personalizable y rica en nutrientes con proteínas magras y cereales integrales.',
                      style: TextStyle(
                        color: _kMuted,
                        fontSize: 13.sp,
                        height: 1.45,
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // ── Chips row ──────────────────────
                    Row(
                      children: [
                        _Chip(
                          icon: Icons.access_time_rounded,
                          label: '20 min',
                        ),
                        SizedBox(width: 8.w),
                        _Chip(
                          icon: Icons.person_outline_rounded,
                          label: '1 porción',
                        ),
                      ],
                    ),

                    SizedBox(height: 28.h),

                    // ── Ingredientes section ───────────
                    Text(
                      'Ingredientes',
                      style: TextStyle(
                        color: _kGreen,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 8.h),
                  ],
                ),
              ),

              // Ingredient rows with full-width dividers
              ..._ingredients.map((ing) => _IngredientRow(ingredient: ing)),

              SizedBox(height: 28.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Preparación section ────────────
                    Text(
                      'Preparación',
                      style: TextStyle(
                        color: _kGreen,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 14.h),

                    // Step rows
                    ..._steps.map((step) => _StepRow(step: step)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Chip (time / portion)
// ─────────────────────────────────────────────────────────
class _Chip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _Chip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: _kChipBg,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: _kGreen.withValues(alpha: 0.25),
          width: 1.w,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: _kGreen, size: 13.sp),
          SizedBox(width: 5.w),
          Text(
            label,
            style: TextStyle(
              color: _kWhite,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────
// Ingredient row — full width, divider bottom
// ─────────────────────────────────────────────────────────
class _IngredientRow extends StatelessWidget {
  final _Ingredient ingredient;
  const _IngredientRow({required this.ingredient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(color: _kDivider, thickness: 1.h, height: 0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  ingredient.name,
                  style: TextStyle(
                    color: _kWhite,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                ingredient.amount,
                style: TextStyle(
                  color: ingredient.isGreen ? _kGreen : _kWhite,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────
// Preparation step row
// ─────────────────────────────────────────────────────────
class _StepRow extends StatelessWidget {
  final _Step step;
  const _StepRow({required this.step});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 14.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number circle
          Container(
            width: 28.w,
            height: 28.h,
            decoration: BoxDecoration(
              color: _kStepBg,
              shape: BoxShape.circle,
              border: Border.all(color: _kStepBorder, width: 1.w),
            ),
            child: Center(
              child: Text(
                '${step.number}',
                style: TextStyle(
                  color: _kWhite,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          // Step text
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: Text(
                step.text,
                style: TextStyle(
                  color: _kMuted,
                  fontSize: 14.sp,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}