// lib/widgets/muscle_group_card.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../modal/muscle_group_data.dart';
import '../../provider/favourite_provider.dart';
import 'exercise_picker.dart';


class MuscleGroupCard extends ConsumerStatefulWidget {
  final MuscleGroup group;

  const MuscleGroupCard({super.key, required this.group});

  @override
  ConsumerState<MuscleGroupCard> createState() => _MuscleGroupCardState();
}

class _MuscleGroupCardState extends ConsumerState<MuscleGroupCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => ExercisePickerSheet(group: widget.group),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorite = ref.watch(groupFavoriteProvider(widget.group.id));
    final hasFavorite = favorite != null;
    final accent = widget.group.accentColor;

    return GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        child: ScaleTransition(
          scale: _scaleAnim,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              color: const Color(0xFF161616),
              borderRadius: BorderRadius.circular(16),
              // Use uniform border — left accent is handled by the Stack overlay below
              border: Border.all(
                color: hasFavorite ? const Color(0xFF222222) : const Color(0xFF1E1E1E),
              ),
            ),
            child: Stack(
              children: [
                // Left accent bar
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: 3,
                    decoration: BoxDecoration(
                      color: hasFavorite ? accent : Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      // Icon box
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: hasFavorite
                              ? accent.withOpacity(0.12)
                              : const Color(0xFF1E1E1E),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: hasFavorite
                                ? accent.withOpacity(0.35)
                                : const Color(0xFF2A2A2A),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            widget.group.icon,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                      ),

                      const SizedBox(width: 14),

                      // Name + exercise
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.group.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: hasFavorite
                                    ? Colors.white
                                    : const Color(0xFFBBBBBB),
                              ),
                            ),
                            const SizedBox(height: 3),
                            AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 300),
                              style: TextStyle(
                                fontSize: 12,
                                color: hasFavorite ? accent : const Color(0xFF555555),
                              ),
                              child: Text(
                                favorite ?? 'No es un favorito',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Action buttons
                      if (hasFavorite) ...[
                        // Remove button
                        GestureDetector(
                          onTap: () => ref
                              .read(favoritesProvider.notifier)
                              .removeFavorite(widget.group.id),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.close_rounded,
                              color: Color(0xFF555555),
                              size: 18,
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        // Edit button
                        GestureDetector(
                          onTap: _openPicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: accent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Editar',
                              style: TextStyle(
                                color: accent,
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ] else ...[
                        // Add button
                        GestureDetector(
                          onTap: _openPicker,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              border: Border.all(color: const Color(0xFF2A2A2A)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Text(
                              'Añadir',
                              style: TextStyle(
                                color: Color(0xFF888888),
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ), // Stack
          ), // AnimatedContainer
        )); // ScaleTransition / GestureDetector
    }
}