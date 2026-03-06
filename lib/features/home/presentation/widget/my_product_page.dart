import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

// ── Models & Providers ───────────────────────────────────────────────────────

class FoodItem {
  final String name;
  final int proteinPerUnit; // in grams
  int quantity;
  bool isChecked;

  FoodItem({
    required this.name,
    required this.proteinPerUnit,
    this.quantity = 1,
    this.isChecked = true,
  });

  int get totalProtein => proteinPerUnit * quantity;
}

final foodItemsProvider = StateNotifierProvider<FoodItemsNotifier, List<FoodItem>>((ref) {
  return FoodItemsNotifier();
});

class FoodItemsNotifier extends StateNotifier<List<FoodItem>> {
  FoodItemsNotifier()
      : super([
    FoodItem(name: 'Salmon', proteinPerUnit: 25, quantity: 2, isChecked: true),
    FoodItem(name: 'Salmon', proteinPerUnit: 25, quantity: 2, isChecked: true),
    FoodItem(name: 'Eggs', proteinPerUnit: 12, quantity: 2, isChecked: true),
    FoodItem(name: 'Tuna', proteinPerUnit: 29, quantity: 2, isChecked: true),
  ]);

  void updateQuantity(int index, int newQty) {
    if (newQty < 1) return;
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) FoodItem(
          name: state[i].name,
          proteinPerUnit: state[i].proteinPerUnit,
          quantity: newQty,
          isChecked: state[i].isChecked,
        ) else state[i],
    ];
  }

  void toggleChecked(int index) {
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) FoodItem(
          name: state[i].name,
          proteinPerUnit: state[i].proteinPerUnit,
          quantity: state[i].quantity,
          isChecked: !state[i].isChecked,
        ) else state[i],
    ];
  }
}

final totalProteinProvider = Provider<int>((ref) {
  final items = ref.watch(foodItemsProvider);
  return items
      .where((item) => item.isChecked)
      .fold(0, (sum, item) => sum + item.totalProtein);
});

// ── Screen ───────────────────────────────────────────────────────────────────

class MyProductPage extends ConsumerWidget {
  const MyProductPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(foodItemsProvider);
    final total = ref.watch(totalProteinProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E14), // very dark blue-black
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Ver en MyProtein',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Header row with subtle gradient
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFF1A3C34), const Color(0xFF0A0E14)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Row(
              children: const [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Name',
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Protein',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Quantity',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    'Total',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),

          // Items list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final rowTotal = item.totalProtein;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Name
                      Expanded(
                        flex: 3,
                        child: Text(
                          item.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Protein per unit
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${item.proteinPerUnit}g',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF34C759), // green
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      // Quantity dropdown
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF1C2526),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade800),
                            ),
                            child: DropdownButton<int>(
                              value: item.quantity,
                              icon: const Icon(Icons.arrow_drop_down, color: Colors.white70, size: 20),
                              underline: const SizedBox(),
                              dropdownColor: const Color(0xFF1C2526),
                              style: const TextStyle(color: Colors.white, fontSize: 15),
                              items: List.generate(10, (i) => i + 1)
                                  .map((q) => DropdownMenuItem<int>(
                                value: q,
                                child: Text('$q'),
                              ))
                                  .toList(),
                              onChanged: (newValue) {
                                if (newValue != null) {
                                  ref.read(foodItemsProvider.notifier).updateQuantity(index, newValue);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      // Checkbox
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Checkbox(
                            value: item.isChecked,
                            activeColor: const Color(0xFF34C759),
                            checkColor: Colors.black,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                            side: const BorderSide(color: Color(0xFF34C759), width: 2),
                            onChanged: (bool? value) {
                              if (value != null) {
                                ref.read(foodItemsProvider.notifier).toggleChecked(index);
                              }
                            },
                          ),
                        ),
                      ),
                      // Total protein
                      Expanded(
                        flex: 2,
                        child: Text(
                          '${item.isChecked ? rowTotal : 0}g',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: item.isChecked ? const Color(0xFF34C759) : Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Bottom total bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF11171D),
              border: Border(top: BorderSide(color: Colors.grey.shade900, width: 1)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Total ${total}g',
                  style: const TextStyle(
                    color: Color(0xFF34C759),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}