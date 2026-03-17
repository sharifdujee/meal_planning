import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../model/ranking_state.dart';

class RankingStatsNotifier extends StateNotifier<RankingStats> {
  RankingStatsNotifier()
      : super(RankingStats(
    currentPosition: 7,
    totalParticipants: 20,
    weeklyPoints: 48,
  ));

  // Method to update stats when data comes from the server
  void updateStats(RankingStats newStats) {
    state = newStats;
  }
}

final rankingStatsProvider =
StateNotifierProvider<RankingStatsNotifier, RankingStats>((ref) {
  return RankingStatsNotifier();
});