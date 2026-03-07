import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/global/show_custom_dialog.dart';
import '../../../../core/utils/icon_path.dart';
import '../../provider/food_selection_provider.dart';

// Provider to hold custom (user-added) intolerances
final customIntolerancesProvider = StateProvider<List<String>>((ref) => []);

class IntoleranciasScreen extends ConsumerWidget {
  const IntoleranciasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFoods = ref.watch(foodSelectionProvider);
    final customItems = ref.watch(customIntolerancesProvider);

    final List<String> presetFoods = [
      "Gluten",
      "Lactosa",
      "Frutos secos",
      "Huevo",
      "Mariscos",
    ];

    final allFoods = [...presetFoods, ...customItems];

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0x33469271),
              Color(0xFF0E1115),
            ],
            stops: [0.0, 0.15],
          ),
        ),
        child: SafeArea(
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

                /// Food List
                Expanded(
                  child: ListView.separated(
                    itemCount: allFoods.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final food = allFoods[index];
                      final isSelected = selectedFoods.contains(food);
                      final isCustom = !presetFoods.contains(food);

                      return _foodTile(
                        food: food,
                        isSelected: isSelected,
                        isCustom: isCustom,
                        onTap: () {
                          ref.read(foodSelectionProvider.notifier).toggle(food);
                        },
                        onDelete: isCustom
                            ? () {
                          ref
                              .read(customIntolerancesProvider.notifier)
                              .update((state) =>
                              state.where((e) => e != food).toList());
                          // Also deselect if selected
                          if (selectedFoods.contains(food)) {
                            ref
                                .read(foodSelectionProvider.notifier)
                                .toggle(food);
                          }
                        }
                            : null,
                      );
                    },
                  ),
                ),

                /// Add Another Button
                Align(
                  alignment: Alignment.centerRight,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      side: const BorderSide(
                        color: Color(0xFF469271),
                        width: 1,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => _showAddItemSheet(context, ref, allFoods),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.add, size: 14, color: Color(0xFF469271)),
                        SizedBox(width: 4),
                        Text(
                          "Añadir otro",
                          style: TextStyle(
                            color: Color(0xFF469271),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Save Button
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
                      showCustomDialog(context, imagePath: IconPath.success, title: "Conferma", buttonText: "Fatto", message: "Il tuo piano è stato aggiunto con successo", onPressed: (){
                        context.pop();
                      });
                    },
                    child: const Text(
                      "Guardar",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAddItemSheet(
      BuildContext context, WidgetRef ref, List<String> existingFoods) {
    final controller = TextEditingController();
    String? errorText;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              // Pushes sheet above keyboard
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF1A1F24),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text(
                      "Añadir intolerancia",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Escribe el nombre de la intolerancia que deseas añadir.",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.5),
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// Text field
                    TextField(
                      controller: controller,
                      autofocus: true,
                      textCapitalization: TextCapitalization.sentences,
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                      cursorColor: const Color(0xFF469271),
                      onChanged: (_) {
                        if (errorText != null) setState(() => errorText = null);
                      },
                      decoration: InputDecoration(
                        hintText: "Ej: Soja, Cacahuetes...",
                        hintStyle: TextStyle(
                          color: Colors.white.withValues(alpha: 0.3),
                          fontSize: 14,
                        ),
                        errorText: errorText,
                        errorStyle: const TextStyle(
                          color: Color(0xFFFF6B6B),
                          fontSize: 12,
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0E1115),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(
                            color: Colors.white.withValues(alpha: 0.12),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF469271),
                            width: 1.5,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B),
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFFFF6B6B),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    /// Action buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () => Navigator.pop(context),
                            child: Text(
                              "Cancelar",
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding:
                              const EdgeInsets.symmetric(vertical: 14),
                              backgroundColor: const Color(0xFF469271),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              final value = controller.text.trim();

                              // Validation
                              if (value.isEmpty) {
                                setState(() =>
                                errorText = "El campo no puede estar vacío");
                                return;
                              }
                              final alreadyExists = existingFoods.any((f) =>
                              f.toLowerCase() == value.toLowerCase());
                              if (alreadyExists) {
                                setState(() =>
                                errorText = "Esta intolerancia ya existe");
                                return;
                              }

                              // Add to custom list
                              ref
                                  .read(customIntolerancesProvider.notifier)
                                  .update((state) => [...state, value]);

                              // Auto-select the new item
                              ref
                                  .read(foodSelectionProvider.notifier)
                                  .toggle(value);

                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Añadir",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _foodTile({
    required String food,
    required bool isSelected,
    required bool isCustom,
    required VoidCallback onTap,
    VoidCallback? onDelete,
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
            width: 1.2,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                food,
                style: const TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),

            // Delete button for custom items
            if (isCustom && onDelete != null) ...[
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onDelete,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.close_rounded,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.35),
                  ),
                ),
              ),
            ],

            isSelected
                ? const Icon(Icons.check_circle, color: Color(0xFF469271))
                : Icon(
              Icons.radio_button_unchecked,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}