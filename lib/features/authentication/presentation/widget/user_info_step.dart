import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/design_system/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

import '../../provider/onboarding_provider.dart';
import '../screen/profile_set_up.dart';
import 'onboarding_scaffold.dart';

// ── Input Card ────────────────────────────────────────────────────────────────

class _InputCard extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const _InputCard({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.dmSans(
            color: AppColor.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 25.h,),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: AppColor.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 6),
              TextFormField(
                initialValue: value,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: onChanged,
                style: GoogleFonts.dmMono(
                  color: AppColor.textPrimary,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: InputBorder.none,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Sex Toggle ────────────────────────────────────────────────────────────────

class _SexToggleCard extends StatelessWidget {
  final String selected; // 'M' or 'F'
  final ValueChanged<String> onChanged;

  const _SexToggleCard({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
         text:  'Sexo',

            color: AppColor.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,

        ),
        SizedBox(height: 25.h,),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          decoration: BoxDecoration(
            color: AppColor.card,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.cardBorder),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(height: 10),
              Row(
                children: [
                  _ToggleButton(
                    label: 'H',
                    isSelected: selected == 'H',
                    onTap: () => onChanged('H'),
                  ),
                  const SizedBox(width: 8),
                  _ToggleButton(
                    label: 'M',
                    isSelected: selected == 'M',
                    onTap: () => onChanged('M'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: isSelected ? AppColor.accent : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? AppColor.accent : AppColor.cardBorder,
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.dmSans(
            color: isSelected ? Colors.black : AppColor.textSecondary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

// ── Main Step ─────────────────────────────────────────────────────────────────

class UserInfoStep extends ConsumerWidget {
  const UserInfoStep({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingProvider);
    final notifier = ref.read(onboardingProvider.notifier);

    return OnboardingScaffold(
      stepIndex: 1,
      title: 'Cuéntanos sobre ti',
      image: IconPath.tapeMeasure,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Row 1: Edad + Sexo
            Row(
              children: [
                Expanded(
                  child: _InputCard(
                    label: 'Edad',
                    value: state.age.toString(),
                    onChanged: (v) {
                      final parsed = int.tryParse(v);
                      if (parsed != null) notifier.setAge(parsed);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _SexToggleCard(
                    selected: state.sex ?? 'M',
                    onChanged: notifier.setSex,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Row 2: Altura (full width)
            _InputCard(
              label: 'Altura (cm)',
              value: state.height.round().toString(),
              onChanged: (v) {
                final parsed = double.tryParse(v);
                if (parsed != null) notifier.setHeight(parsed);
              },
            ),

            const SizedBox(height: 14),

            // Row 3: Peso actual + Peso objetivo
            Row(
              children: [
                Expanded(
                  child: _InputCard(
                    label: 'Peso actual (kg)',
                    value: state.weight.round().toString(),
                    onChanged: (v) {
                      final parsed = double.tryParse(v);
                      if (parsed != null) notifier.setWeight(parsed);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _InputCard(
                    label: 'Peso objetivo (kg)',
                    value: state.targetWeight.round().toString(),
                    onChanged: (v) {
                      final parsed = double.tryParse(v);
                      if (parsed != null) notifier.setTargetWeight(parsed);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}