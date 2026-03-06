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
import 'package:meal_planning/core/utils/icon_path.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

// ── Nav color tokens (from screenshot) ────────────────────
//  Background : #2C2C2E  dark gray surface
//  Unselected : #636366  muted mid-gray icons + labels
//  Selected   : #FFFFFF  full white icon + bold white label
const _kNavBg      = Color(0xFF2C2C2E);
const _kUnselected = Color(0xFF636366);
const _kSelected   = Colors.white;

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

  static const _icons = [
    IconPath.home,
    IconPath.dashBoard,
    IconPath.registration,
    IconPath.ranking,
    IconPath.progress,
    IconPath.profile,
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedIndexProvider);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      // ✅ light = white status bar icons on dark background
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: IndexedStack(
          index: selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            // ✅ #2C2C2E matches the dark gray in the screenshot
            color: _kNavBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x66000000),
                blurRadius: 20,
                offset: Offset(0, -2),
              ),
            ],
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
              // ✅ Set here too — BottomNavigationBar paints its own
              //    background on top of the Container, so both must match
              backgroundColor: _kNavBg,
              selectedItemColor: _kSelected,
              unselectedItemColor: _kUnselected,
              selectedFontSize: 11,
              unselectedFontSize: 11,
              // ✅ Bold label when selected (clearly visible in screenshot)
              selectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              elevation: 0,
              items: List.generate(_labels.length, (i) {
                return BottomNavigationBarItem(
                  label: _labels[i],
                  // ✅ Unselected icon — #636366 muted gray
                  icon: Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SvgPicture.asset(
                      _icons[i],
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        _kUnselected,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  // ✅ Selected icon — full white
                  activeIcon: Padding(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: SvgPicture.asset(
                      _icons[i],
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        _kSelected,
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