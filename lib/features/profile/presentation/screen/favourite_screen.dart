


// lib/screens/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modal/muscle_group_data.dart';
import '../../provider/favourite_provider.dart';
import '../widget/muscle_group.dart';


class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(favoritesCountProvider);
    final progress = ref.watch(favoritesProgressProvider);
    final allSet = ref.watch(allFavoritesSetProvider);
    final total = muscleGroups.length;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      body: Stack(
        children: [
          // Background radial glow behind header
          Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 260,
                height: 160,
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF00FF87).withValues(alpha: 0.10),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────
                Padding(
                  padding:
                  const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => Navigator.maybePop(context),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: Color(0xFF888888),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'MIS EJERCICIOS\n',
                                    style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 26,
                                      color: Color(0xFFF0F0F0),
                                      letterSpacing: 1.5,
                                      height: 1.1,
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'FAVORITOS',
                                    style: TextStyle(
                                      fontFamily: 'BebasNeue',
                                      fontSize: 26,
                                      color: Color(0xFF00FF87),
                                      letterSpacing: 1.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // Progress pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                              color:
                              const Color(0xFF00FF87).withValues(alpha: 0.10),
                              border: Border.all(
                                color:
                                const Color(0xFF00FF87).withValues(alpha: 0.30),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$count/$total',
                              style: const TextStyle(
                                color: Color(0xFF00FF87),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 6),
                      const Padding(
                        padding: EdgeInsets.only(left: 32),
                        child: Text(
                          'Selecciona tu ejercicio preferido por grupo muscular',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF555555),
                          ),
                        ),
                      ),

                      const SizedBox(height: 14),

                      // Progress bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: const Color(0xFF222222),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF00FF87)),
                          minHeight: 3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // ── Cards list ───────────────────────────────────
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
                    itemCount: muscleGroups.length,
                    itemBuilder: (context, index) {
                      return MuscleGroupCard(group: muscleGroups[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Bottom CTA ──────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xFF0D0D0D),
                    Color(0xFF0D0D0D),
                    Colors.transparent,
                  ],
                  stops: [0.0, 0.65, 1.0],
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                MediaQuery.of(context).padding.bottom + 16,
              ),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: allSet
                      ? const Color(0xFF00FF87)
                      : const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: allSet
                        ? const Color(0xFF00FF87)
                        : const Color(0xFF2A2A2A),
                  ),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: allSet ? () {} : null,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Center(
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 300),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: allSet
                                ? Colors.black
                                : const Color(0xFF555555),
                            letterSpacing: 0.3,
                          ),
                          child: Text(
                            allSet
                                ? '✓  Guardar mis favoritos'
                                : 'Añadir ${total - count} más para completar',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}