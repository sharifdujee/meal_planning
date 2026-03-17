import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planning/core/utils/image_path.dart';
import '../model/ranking_page State.dart';

class RankingNotifier extends AsyncNotifier<RankingPageState> {
  @override
  FutureOr<RankingPageState> build() async {
    final users = await _fetchRankings();
    return RankingPageState(
      users: users,
      activeTab: RankingTab.compite,
      isPrivateLeagueEnabled: false, // Match the model name
    );
  }

  void setTab(RankingTab tab) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(activeTab: tab));
    }
  }

  void togglePrivateLeagues(bool value) {
    final current = state.value;
    if (current != null) {
      state = AsyncData(current.copyWith(isPrivateLeagueEnabled: value));
    }
  }

  Future<List<UserRank>> _fetchRankings() async {
    // Simulated network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return [
      UserRank(id: '1',userAvater: ImagePath.user_1, name: 'Carlos García', score: 119, rank: 1, streak: 'Racha de 7 días'),
      UserRank(id: '2',userAvater: ImagePath.user_2 ,name: 'María López', score: 108, rank: 2, streak: 'Racha de 7 días'),
      UserRank(id: '3',userAvater: ImagePath.user_3 ,name: 'Alejandro Martin', score: 108, rank: 3, streak: 'Racha de 7 días'),
      UserRank(id: '4',userAvater: ImagePath.user_4,name: 'Lucia Fernández', score: 95, rank: 4, streak: 'Racha de 7 días'),
      UserRank(id: '5', userAvater: ImagePath.user_5, name: 'Roberto Ruiz', score: 82, rank: 5, streak: 'Racha de 7 días'),
      UserRank(id: '6',userAvater: ImagePath.user_6, name: 'Tú', score: 48, rank: 6, streak: 'Racha de 7 días'),
    ];
  }
}

final rankingNotifierProvider = AsyncNotifierProvider<RankingNotifier, RankingPageState>(() {
  return RankingNotifier();
});