import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:meal_planning/features/progress/presentation/screen/progress_screen.dart';
import 'package:meal_planning/features/ranking/presentation/screen/ranking_screen.dart';
import 'package:meal_planning/features/registration/presentation/screen/registration_screen.dart';
import 'package:meal_planning/features/week/presentation/screen/week_screen.dart';
import 'package:meal_planning/features/home/presentation/screen/home_screen.dart';
import 'package:meal_planning/features/profile/presentation/screen/profile_screen.dart';
import 'package:meal_planning/core/utils/app_color.dart';
import 'package:meal_planning/core/utils/icon_path.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class CustomBottomNavBar extends ConsumerWidget {
  const CustomBottomNavBar({super.key});

  static const _screens = [
    HomeScreen(),
    WeekScreen(),
    RegistrationScreen(),
    RankingScreen(),
    ProgressScreen(),
    ProfileScreen(),
  ];

  static const _labels = [
    'Hoy',
    'Semana',
    'Registro',
    'Ranking',
    'Progreso',
    'Perfil',
  ];

  // Replace with correct IconPath constants when available
  static const _icons = [
    IconPath.home,
    IconPath.dashBoard, // swap: IconPath.week
    IconPath.home, // swap: IconPath.log
    IconPath.home, // swap: IconPath.ranking
    IconPath.home, // swap: IconPath.progress
    IconPath.home, // swap: IconPath.profile
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        // ✅ Full-screen body — screens fill everything above the nav bar
        body: IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
        // ✅ Nav bar is a Scaffold property — always pinned to the bottom
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, -2),
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            child: BottomNavigationBar(
              currentIndex: selectedIndex,
              onTap: (i) =>
              ref.read(selectedIndexProvider.notifier).state = i,
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              selectedItemColor: AppColor.accent,
              unselectedItemColor: const Color(0xFF9E9E9E),
              selectedFontSize: 11,
              unselectedFontSize: 11,
              elevation: 0,
              items: List.generate(_labels.length, (i) {
                final isSelected = selectedIndex == i;
                return BottomNavigationBarItem(
                  label: _labels[i],
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SvgPicture.asset(
                      _icons[i],
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF9E9E9E),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SvgPicture.asset(
                      _icons[i],
                      width: 22,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        AppColor.accent,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}