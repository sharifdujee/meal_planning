

// lib/widgets/exercise_picker_sheet.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modal/muscle_group_data.dart';
import '../../provider/favourite_provider.dart';


class ExercisePickerSheet extends ConsumerWidget {
  final MuscleGroup group;

  const ExercisePickerSheet({super.key, required this.group});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentFavorite = ref.watch(groupFavoriteProvider(group.id));

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF161616),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(
          top: BorderSide(color: Color(0xFF2A2A2A)),
          left: BorderSide(color: Color(0xFF2A2A2A)),
          right: BorderSide(color: Color(0xFF2A2A2A)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF333333),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header
          Row(
            children: [
              Text(group.icon, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    group.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: group.accentColor,
                      letterSpacing: 1.5,
                    ),
                  ),
                  Text(
                    currentFavorite != null
                        ? 'Cambiar ejercicio favorito'
                        : 'Elegir ejercicio favorito',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF555555),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Exercise options
          ...group.exercises.map((exercise) {
            final isSelected = currentFavorite == exercise;
            return GestureDetector(
              onTap: () {
                ref
                    .read(favoritesProvider.notifier)
                    .setFavorite(group.id, exercise);
                Navigator.pop(context);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected
                      ? group.accentColor.withOpacity(0.08)
                      : const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected
                        ? group.accentColor.withOpacity(0.6)
                        : const Color(0xFF222222),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      exercise,
                      style: TextStyle(
                        fontSize: 14,
                        color:
                        isSelected ? group.accentColor : const Color(0xFFCCCCCC),
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_rounded,
                        color: group.accentColor,
                        size: 18,
                      ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}