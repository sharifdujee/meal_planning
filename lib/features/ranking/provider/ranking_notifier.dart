import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/ranking_page State.dart';

class RankingNotifier extends AsyncNotifier<RankingPageState> {
  @override
  FutureOr<RankingPageState> build() async {
    final users = await _fetchRankings();
    return RankingPageState(
      users: users,
      activeTab: RankingTab.compite,
      isPrivateLeagueEnabled: false,
    );
  }

  void setTab(RankingTab tab) {
    state = state.whenData((current) => current.copyWith(activeTab: tab));
  }

  void togglePrivateLeagues(bool value) {
    state = state.whenData((current) => current.copyWith(isPrivateLeagueEnabled: value));
  }

  Future<List<UserRank>> _fetchRankings() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      UserRank(id: '1', name: 'Carlos García', score: 119, rank: 1, streak: '7 días'),
      UserRank(id: '2', name: 'María López', score: 108, rank: 2, streak: '7 días'),
      UserRank(id: '3', name: 'Alejandro Martin', score: 108, rank: 3, streak: '7 días'),
      UserRank(id: '6', name: 'Tú', score: 108, rank: 6, streak: '7 días'),
    ];
  }
}

final rankingNotifierProvider = AsyncNotifierProvider<RankingNotifier, RankingPageState>(() {
  return RankingNotifier();
});