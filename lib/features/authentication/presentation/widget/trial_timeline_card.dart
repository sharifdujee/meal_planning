// ── TrialTimelineCard ────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/design_system/app_color.dart';

// ── TrialTimelineCard ────────────────────────────────────────────────────────

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrialTimelineCard extends StatelessWidget {
  const TrialTimelineCard({super.key});

  static const _steps = [
    (
    'Hoy',
    'Empiezas. Acceso completo a\nentrenamientos, hábitos y progreso.',
    Icons.lock_outline_rounded,
    true,
    ),
    (
    'Día 6',
    'Ya tienes resultados. Te avisamos antes\nde perderlos.',
    Icons.notifications_none_rounded,
    false,
    ),
    (
    'Día 7',
    'Decides: volver atrás o seguir avanzando',
    Icons.mail_outline_rounded,
    false,
    ),
  ];

  static const _green = Color(0xFF3DDC97);
  static const _greenDim = Color(0xFF2A8C62);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _steps.asMap().entries.map((entry) {
        final idx = entry.key;
        final step = entry.value;
        final isLast = idx == _steps.length - 1;
        final isActive = step.$4;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Icon + connecting line ──
              SizedBox(
                width: 48,
                child: Column(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? _green
                            : const Color(0xFF1A2920),
                        border: isActive
                            ? null
                            : Border.all(
                          color: const Color(0xFF2C3E35),
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        step.$3,
                        color: isActive ? Colors.black : const Color(0xFF4A6A58),
                        size: 22,
                      ),
                    ),
                    if (!isLast)
                      Expanded(
                        child: Container(
                          width: 2,
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                _greenDim.withOpacity(0.7),
                                _greenDim.withOpacity(0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(width: 16),

              // ── Text content ──
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: isLast ? 0 : 28,
                    top: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step.$1,
                        style: GoogleFonts.dmSans(
                          color: isActive ? _green : Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step.$2,
                        style: GoogleFonts.dmSans(
                          color: const Color(0xFF6B8C7A),
                          fontSize: 13,
                          height: 1.45,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}





class PricingCardsRow extends StatefulWidget {
  const PricingCardsRow({super.key});

  @override
  State<PricingCardsRow> createState() => _PricingCardsRowState();
}

class _PricingCardsRowState extends State<PricingCardsRow> {
  int _selected = 1; // default: Imperfecto Pro

  static const _green = Color(0xFF3DDC97);
  static const _cardBg = Color(0xFF0F1E18);
  static const _cardBorder = Color(0xFF1E3028);

  static const _plans = [
    _Plan(
      title: 'Gratis',
      price: '€0.00',
      period: '/mes',
      badge: null,
      isBest: false,
      features: ['Acceso base', 'Empieza'],
    ),
    _Plan(
      title: 'Imperfecto Pro',
      price: '€9.99',
      period: '/mes',
      badge: 'RECOMENDADO',
      isBest: true,
      features: ['Progreso completo', 'Rutinas + hábitos', 'Acceso ilimitado'],
    ),
    _Plan(
      title: 'Ranking',
      price: '€3.49',
      period: '/mes',
      badge: null,
      isBest: false,
      features: ['Compite', 'Ranking'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(_plans.length, (i) {
        final plan = _plans[i];
        final isSelected = _selected == i;

        return Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selected = i),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Badge or spacer ──
                  if (plan.badge != null)
                    Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        plan.badge!,
                        style: GoogleFonts.dmSans(
                          color: Colors.black,
                          fontSize: 9,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.5,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 33),

                  // ── Card ──
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    curve: Curves.easeOutCubic,
                    padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                    decoration: BoxDecoration(
                      color: _cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isSelected ? _green : _cardBorder,
                        width: isSelected ? 2 : 1,
                      ),
                      boxShadow: isSelected
                          ? [
                        BoxShadow(
                          color: _green.withOpacity(0.18),
                          blurRadius: 14,
                          offset: const Offset(0, 4),
                        ),
                      ]
                          : null,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Title
                        Text(
                          plan.title,
                          style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Price row
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: plan.price,
                                style: GoogleFonts.dmSans(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                  height: 1.0,
                                ),
                              ),
                              TextSpan(
                                text: plan.period,
                                style: GoogleFonts.dmSans(
                                  color: const Color(0xFF5A8070),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Features
                        ...plan.features.map(
                              (f) => Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '✓ ',
                                  style: TextStyle(
                                    color: Color(0xFF3DDC97),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    f,
                                    style: GoogleFonts.dmSans(
                                      color: const Color(0xFF6B8C7A),
                                      fontSize: 10,
                                      height: 1.3,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _Plan {
  final String title;
  final String price;
  final String period;
  final String? badge;
  final bool isBest;
  final List<String> features;

  const _Plan({
    required this.title,
    required this.price,
    required this.period,
    required this.badge,
    required this.isBest,
    required this.features,
  });
}
