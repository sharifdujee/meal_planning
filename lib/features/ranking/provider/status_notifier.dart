import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../core/utils/icon_path.dart';
import '../model/status_data.dart';

class StatusNotifier extends StateNotifier<StatusData> {
  StatusNotifier()
      : super(StatusData(
    leagueName: "Bronce III",
    leagueImageUrl: IconPath.bronze3, // Pass the asset string here
    daysRemaining: 3,
    reachday: 4,
  ));

  // Method to update data from backend
  void updateStatus(StatusData newData) {
    state = newData;
  }

  // Method to simulate a refresh
  Future<void> refreshStatus() async {
    // In a real app, you'd fetch from a repository here
    await Future.delayed(const Duration(milliseconds: 500));
    state = StatusData(
      leagueName: "Bronce III",
      leagueImageUrl: "https://cdn-icons-png.flaticon.com/512/2583/2583344.png",
      daysRemaining: 2, // Changed to show update
      reachday: 5,     // Changed to show update
    );
  }
}

// 2. The Provider
final statusNotifierProvider = StateNotifierProvider<StatusNotifier, StatusData>((ref) {
  return StatusNotifier();
});