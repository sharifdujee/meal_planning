import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final selectedRegenerateOptionsProvider =
StateProvider<Set<String>>((ref) => {'entrenamientos', 'comidas'});

class RegenerateScreen extends ConsumerWidget {
  const RegenerateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedRegenerateOptionsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x2B469271),
              Color(0xFF0E1115),
            ],
            stops: [0.0, 0.22],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                /// ── Header ──
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 22),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Regenerar mi plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                /// ── Title ──
                const Text(
                  '¿Qué quieres cambiar?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -0.5,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Selecciona qué partes regenerar. El resto permanecerá igual.',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 28),

                /// ── Option Cards ──
                _OptionCard(
                  id: 'entrenamientos',
                  icon: Icons.fitness_center_rounded,
                  title: 'Entrenamientos',
                  subtitle:
                  'Nuevas sesiones adaptadas a tu\ntiempo y objetivos.',
                  isSelected: selected.contains('entrenamientos'),
                  onTap: () => _toggle(ref, 'entrenamientos'),
                ),

                const SizedBox(height: 14),

                _OptionCard(
                  id: 'comidas',
                  icon: Icons.restaurant_rounded,
                  title: 'Comidas',
                  subtitle: 'Nuevas recetas respetando tus\npreferencias.',
                  isSelected: selected.contains('comidas'),
                  onTap: () => _toggle(ref, 'comidas'),
                ),

                const Spacer(),

                /// ── CTA Button ──
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selected.isEmpty
                          ? const Color(0xFF469271).withValues(alpha: 0.4)
                          : const Color(0xFF469271),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    onPressed: selected.isEmpty ? null : () {},
                    child: const Text(
                      'Regenerar con estos cambios',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _toggle(WidgetRef ref, String id) {
    ref.read(selectedRegenerateOptionsProvider.notifier).update((state) {
      final copy = {...state};
      if (copy.contains(id)) {
        copy.remove(id);
      } else {
        copy.add(id);
      }
      return copy;
    });
  }
}

class _OptionCard extends StatelessWidget {
  final String id;
  final IconData icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _OptionCard({
    required this.id,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F24),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF469271)
                : Colors.white.withValues(alpha: 0.1),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            /// Icon container
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: isSelected
                    ? const Color(0xFF469271).withValues(alpha: 0.18)
                    : Colors.white.withValues(alpha: 0.07),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? const Color(0xFF469271)
                    : Colors.white.withValues(alpha: 0.45),
                size: 22,
              ),
            ),

            const SizedBox(width: 14),

            /// Text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.85),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.45),
                      fontSize: 12.5,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            /// Radio indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? const Color(0xFF469271)
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xFF469271)
                      : Colors.white.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check_rounded,
                  color: Colors.white, size: 15)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}