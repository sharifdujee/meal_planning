import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/provider/shopping_list_provider.dart';
import '../../model/shopping_items.dart';

class ShoppingListScreen extends ConsumerWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(shoppingListProvider);
    final categoryList = categories.entries.toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.0, 0.2],
            colors: [
              const Color(0xFF469271).withValues(alpha: 0.20),
              const Color(0xFF0E1115),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Custom Header
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(IconPath.arrowLeft, height: 24.w, width: 24.w),
                      ),
                    ),
                    CustomText(
                      text: "Lista de la compra",
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final entry = categoryList[index];
                    final String categoryTitle = entry.key;
                    final List<ShoppingItems> items = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 25.h, bottom: 15.h),
                          child: CustomText(
                            text: categoryTitle,
                            fontSize: 16.sp,
                            color: const Color(0xFF6BC799),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: items.length,
                          itemBuilder: (context, itemIndex) {
                            return _buildShoppingTile(
                                ref,
                                categoryTitle,
                                items[itemIndex]
                            );
                          },
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingTile(WidgetRef ref, String category, ShoppingItems item) {
    return GestureDetector(
      onTap: () {
        // Toggle logic
        ref.read(shoppingListProvider.notifier).toggleItem(category, item.name);
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        child: Row(
          children: [
            // Workable Radio/Checkbox
            Container(
              width: 20.w,
              height: 20.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    width: 1.5,
                    color: item.isChecked ? const Color(0xFF6BC799) : const Color(0xFF4B5563)
                ),
                color: item.isChecked ? const Color(0xFF6BC799).withValues(alpha: 0.1) : Colors.transparent,
              ),
              child: item.isChecked
                  ? Icon(Icons.check, size: 14.sp, color: const Color(0xFF6BC799))
                  : null,
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: item.name,
                    fontSize: 14.sp,
                    color: item.isChecked ? const Color(0xFF4B5563) : const Color(0xFFB6BAC3),
                  ),
                  if (item.subtitle != null)
                    CustomText(
                      text: item.subtitle!,
                      fontSize: 10.sp,
                      color: const Color(0xFF5B616E),
                    ),
                ],
              ),
            ),
            CustomText(
              text: item.quantity,
              fontSize: 14.sp,
              color: const Color(0xFF6BC799),
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}