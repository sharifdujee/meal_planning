import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../provider/food_selection_provider.dart';

class DontLikeFoodScreen extends ConsumerWidget {
  const DontLikeFoodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFoods = ref.watch(foodSelectionProvider);

    final List<String> foods = [
      "Verduras",
      "Pescado",
      "Legumbres",
      "Carne roja",
      "Huevos",
      "Lácteos",
      "Salmón a la parrilla con espárragos",
    ];

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
                /// 🔹 Header
                Row(

                  children: [
                    GestureDetector(
                      onTap: (){
                        context.pop();
                      },
                      child: const Icon(Icons.arrow_back_rounded,
                          color: Colors.white, size: 20),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        "Comidas que no me gustan",
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

                /// 🔹 Food List
                Expanded(
                  child: ListView.separated(
                    itemCount: foods.length,
                    separatorBuilder: (_, __) =>
                    const SizedBox(height: 14),
                    itemBuilder: (context, index) {
                      final food = foods[index];
                      final isSelected =
                      selectedFoods.contains(food);

                      return _foodTile(
                        food: food,
                        isSelected: isSelected,
                        onTap: () {
                          ref
                              .read(foodSelectionProvider.notifier)
                              .toggle(food);
                        },
                      );
                    },
                  ),
                ),

                /// 🔹 Add Another Button
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
                    onPressed: () {},
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // 👈 VERY IMPORTANT
                      children: const [
                        Icon(
                          Icons.add,
                          size: 14,
                          color: Color(0xFF469271),
                        ),
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

                /// 🔹 Save Button
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
                    onPressed: () {},
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

  /// 🔹 Food Tile Widget
  Widget _foodTile({
    required String food,
    required bool isSelected,
    required VoidCallback onTap,
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
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
            isSelected
                ? const Icon(
              Icons.check_circle,
              color: Color(0xFF469271),
            )
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