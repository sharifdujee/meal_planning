import 'package:flutter/material.dart';
import 'package:meal_planning/features/authentication/presentation/widget/trial_timeline_card.dart';



class SubscriptionStep extends StatelessWidget {
  const SubscriptionStep({super.key});

  static const _bgTop = Color(0xFF0E1A16);
  static const _bgBottom = Color(0xFF0A1411);
  static const _accent = Color(0xFF3DDC97);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_bgTop, _bgBottom],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            children: [
              /// Top Section (Header)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SizedBox(height: 16),

                    Text(
                      "Suscripción",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      textAlign: TextAlign.center,
                      "Empieza a construir disciplina en 7 días",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              /// Scrollable Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      /// Timeline
                      TrialTimelineCard(),

                      SizedBox(height: 32),

                      /// Pricing
                      PricingCardsRow(),

                      SizedBox(height: 120), // space for bottom button
                    ],
                  ),
                ),
              ),

              /// Bottom CTA Button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      // Handle subscription
                    },
                    child: const Text(
                      "Continuar",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


///