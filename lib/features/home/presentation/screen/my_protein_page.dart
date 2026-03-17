import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provider/protein_notifier.dart';

class MyProteinPage extends ConsumerWidget {
  const MyProteinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(proteinProvider);
    final notifier = ref.read(proteinProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFF0E1115),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF469271).withOpacity(0.2),
              const Color(0xFF0E1115),
            ],
            stops: const [0.0, 0.05],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header navigation
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text(
                      "Ver en MyProtein",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              // Table Container
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Container(
                  clipBehavior: Clip.antiAlias, // Ensures internal row colors don't bleed
                  decoration: BoxDecoration(
                    color: const Color(0xFF202122).withValues(alpha: 0.60),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 1. Header Row (Different Background)
                      Container(
                        color: const Color(0xFF202122), // Darker shade for header
                        child: _buildRow(["Nombre", "Proteína", "Cantidad", "Total"], isHeader: true),
                      ),
                      const Divider(color: Color(0xFF20262D), height: 1),

                      // 2. Food Items List using ListView.builder
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              _buildFoodRow(items[index]),
                              if (index != items.length - 1)
                                const Divider(color: Color(0xFF20262D), height: 1),
                            ],
                          );
                        },
                      ),

                      const Divider(color: Color(0xFF20262D), height: 1),

                      // 3. Total Row (Slightly different background/elevation feel)
                      Container(
                        color: const Color(0xFF202122), // Matches header for symmetry
                        child: _buildTotalRow(notifier.grandTotal),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<String> cells, {bool isHeader = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(cells[0], style: _rowStyle(isHeader, isName: true))),
          Expanded(child: Text(cells[1], textAlign: TextAlign.center, style: _rowStyle(isHeader))),
          Expanded(child: Text(cells[2], textAlign: TextAlign.center, style: _rowStyle(isHeader))),
          Expanded(child: Text(cells[3], textAlign: TextAlign.end, style: _rowStyle(isHeader))),
        ],
      ),
    );
  }

  TextStyle _rowStyle(bool isHeader, {bool isName = false}) => TextStyle(
    color: isHeader ? Color(0xFFF7F8F8) : (isName ? Colors.grey[400]: const Color(0xFFB6BAC3)),
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: isHeader ? 0.5 : 0,
  );

  Widget _buildFoodRow(FoodItem item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(item.name, style: TextStyle(color: Colors.grey[400], fontSize: 14.sp)),
          ),
          Expanded(
            child: Text("${item.proteinPerUnit}g",
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFF6BC799), fontWeight: FontWeight.w600, fontSize: 14.sp)),
          ),
          Expanded(
            child: Text("${item.quantity}",
                textAlign: TextAlign.center,
                style: TextStyle(color: const Color(0xFF6BC799), fontWeight: FontWeight.w600, fontSize: 14.sp)),
          ),
          Expanded(
            child: Text("${item.totalProtein}g",
                textAlign: TextAlign.end,
                style: TextStyle(color: const Color(0xFF6BC799), fontWeight: FontWeight.w600, fontSize: 14.sp)),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(int total) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      child: Row(
        children: [
          Text("Total", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.sp)),
          const Spacer(),
          Text("Total ", style: TextStyle(color: Colors.grey[500], fontSize: 13.sp)),
          Text("${total}g", style: TextStyle(color: const Color(0xFF6BC799), fontWeight: FontWeight.bold, fontSize: 15.sp)),
        ],
      ),
    );
  }
}