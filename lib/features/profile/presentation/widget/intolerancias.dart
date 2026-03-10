import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/global/show_custom_dialog.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/food_selection_provider.dart';

/// Provider holding ALL intolerances (preset + custom)
final intolerancesProvider = StateProvider<List<String>>((ref) => [
  "Gluten",
  "Lactosa",
  "Frutos secos",
  "Huevo",
  "Mariscos",
]);

class IntoleranciasScreen extends ConsumerWidget {
  const IntoleranciasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFoods = ref.watch(foodSelectionProvider);
    final allFoods = ref.watch(intolerancesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              /// Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: const Icon(Icons.arrow_back_rounded,
                        color: Colors.white, size: 20),
                  ),
                  const SizedBox(width: 100),
                  const Expanded(
                    child: Text(
                      "Intolerancias",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// List
              Expanded(
                child: ListView.separated(
                  itemCount: allFoods.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final food = allFoods[index];
                    final isSelected = selectedFoods.contains(food);

                    return _foodTile(
                      food: food,
                      isSelected: isSelected,
                      onTap: () {
                        ref.read(foodSelectionProvider.notifier).toggle(food);
                      },

                      /// DELETE FUNCTION
                      onDelete: () {
                        ref.read(intolerancesProvider.notifier).update(
                              (state) =>
                              state.where((e) => e != food).toList(),
                        );

                        if (selectedFoods.contains(food)) {
                          ref
                              .read(foodSelectionProvider.notifier)
                              .toggle(food);
                        }
                      },
                    );
                  },
                ),
              ),

              /// Add button
              Align(
                alignment: Alignment.centerRight,
                child: OutlinedButton(
                  onPressed: () =>
                      _showAddItemSheet(context, ref, allFoods),
                  child: const Text("Añadir otro"),
                ),
              ),

              const SizedBox(height: 20),

              /// Save
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF469271),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    showCustomDialog(
                      context,
                      imagePath: IconPath.success,
                      title: "Confirmación",
                      buttonText: "Hecho",
                      message:
                      "Tus intolerancias se han actualizado correctamente en la lista.",
                      onPressed: () {
                        context.pop();
                      },
                    );
                  },
                  child: const Text(
                    "Guardar",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// ADD ITEM SHEET
  void _showAddItemSheet(
      BuildContext context, WidgetRef ref, List<String> existingFoods) {
    final controller = TextEditingController();
    String? errorText;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: const EdgeInsets.all(24),
              color: const Color(0xFF1A1F24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  TextField(
                    controller: controller,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Ej: Soja",
                      errorText: errorText,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      final value = controller.text.trim();

                      if (value.isEmpty) {
                        setState(() {
                          errorText = "El campo no puede estar vacío";
                        });
                        return;
                      }

                      final exists = existingFoods.any((e) =>
                      e.toLowerCase() == value.toLowerCase());

                      if (exists) {
                        setState(() {
                          errorText = "Esta intolerancia ya existe";
                        });
                        return;
                      }

                      /// ADD ITEM
                      ref.read(intolerancesProvider.notifier).update(
                              (state) => [...state, value]);

                      ref
                          .read(foodSelectionProvider.notifier)
                          .toggle(value);

                      Navigator.pop(context);
                    },
                    child: const Text("Añadir"),
                  )
                ],
              ),
            ),
          );
        });
      },
    );
  }

  /// FOOD TILE
  Widget _foodTile({
    required String food,
    required bool isSelected,
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1F24),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? const Color(0xFF469271)
                : Colors.white.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [

            Expanded(
              child: Text(
                food,
                style: const TextStyle(color: Colors.white),
              ),
            ),

            /// DELETE BUTTON
            GestureDetector(
              onTap: onDelete,
              child: Icon(
                Icons.close,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),

            const SizedBox(width: 10),

            isSelected
                ? const Icon(Icons.check_circle, color: Color(0xFF469271))
                : Icon(Icons.radio_button_unchecked,
                color: Colors.white.withValues(alpha: 0.4)),
          ],
        ),
      ),
    );
  }
}