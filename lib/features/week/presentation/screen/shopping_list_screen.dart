import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:meal_planning/core/global/custom_text.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/provider/shopping_list_provider.dart';

import '../../model/shopping_items.dart';

class ShoppingListScreen extends ConsumerWidget{
  const ShoppingListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final categories = ref.watch(shoppingListProvider);
    final categoryList = categories.entries.toList();

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentGeometry.topCenter,
              end: AlignmentGeometry.bottomCenter,
              colors: [
                const Color(0xFF469271).withValues(alpha: 0.2),
                const Color(0xFF0E1115),
              ],
            )
          ),
          child: SizedBox(
            child: SafeArea(
              child:Column(
                children: [
                  Padding(
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w,vertical: 20.h),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Image.asset(IconPath.arrowLeft,height: 24.w,width: 24.w,),
                        ),
                        Padding(
                          padding: EdgeInsetsGeometry.symmetric(horizontal: 45.w),
                          child: CustomText(
                            text: "Lista de la compra",
                            color: Colors.white,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h,),

                  // content
                  Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        itemCount: categoryList.length,
                        itemBuilder: (context, index){
                          final entry = categoryList [index];
                          final String categoryTitle = entry.key;
                          final List<ShoppingItems> items = entry. value;
                          return Column(
                            children: [
                              Padding(
                                padding: EdgeInsetsGeometry.only(top: 24.h,bottom: 12.h),
                                child: CustomText(
                                  text: categoryTitle,
                                  fontSize: 16.sp,
                                  color: Color(0xFF6BC799),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                itemBuilder: (context,itemIndex){
                                  return _buildShoppingTile(items[itemIndex]);
                                }
                              )
                            ],
                          );
                        }
                      )
                  ),
                ],
              )
                    ),
          ),
        ),
      ),
    );
  }

  Widget _buildShoppingTile(ShoppingItems item){
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(vertical: 12.h),
      child: Row(
        children: [
          Container(
            width: 22.w,
            height: 22.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Color(0xFF6B7280))
            ),
          ),
          SizedBox(width: 16.w,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: item.name,
                  fontSize: 14.sp,
                  color: Color(0xFFB6BAC3),
                ),
                if(item.subtitle !=null)
                  CustomText(
                    text: item.subtitle!,
                    fontSize: 10.sp,
                    color: Color(0xFf5B616E),
                  ),
              ],
            ),
          ),
          CustomText(
            text: item.quantity,
            fontSize: 14.sp,
            color: Color(0xFF6BC799),
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}