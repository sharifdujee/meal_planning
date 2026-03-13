import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/ranking_page State.dart';
import '../../provider/ranking_notifier.dart';
import '../../widgets/entreba_ahora_button.dart';
import '../../widgets/private_league_toggle.dart';
import '../../widgets/selection_devider.dart';
import '../../widgets/status_card.dart';
import '../../widgets/tab_item.dart';
import '../../widgets/user_Tile.dart';

import '../../../../core/global/custom_text.dart';
import '../../../../core/utils/icon_path.dart';


class RankingScreen extends ConsumerWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncState = ref.watch(rankingNotifierProvider);

    return Scaffold(
      body: Container(
        //Page Color
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
        child: asyncState.when(
          loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF469271))),
          error: (err, stack) => Center(child: Text('Error: $err', style: const TextStyle(color: Colors.white))),
          data: (state) {
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      children: [
                        SizedBox(height: 52.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const BackButton(color: Colors.white),
                            CustomText(
                              text: "Clasificación",
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                            ),
                            Image.asset(IconPath.info, height: 24.h, width: 24.w),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        if (state.activeTab == RankingTab.compite)
                          PrivateLeagueToggle(ref: ref, isEnabled: state.isPrivateLeagueEnabled),
                        SizedBox(height: 8.h,),
                        TabSwitcher(ref: ref, activeTab: state.activeTab),
                        const StatusCard(),
                        SizedBox(height: 24.h),
                        const SelectionDevider(label: "ZONA DE ASCENSO (1-5)"),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) => UserTile(user: state.users[index]),
                      childCount: state.users.length,
                    ),
                  ),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 120.h)),
              ],
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: const EntrebaAhoraButton(),
    );
  }
}