import 'package:flutter_riverpod/flutter_riverpod.dart'; // Cleaned up import
import 'package:flutter_riverpod/legacy.dart';
import '../model/ranking_user.dart';

enum TimeFrame { semana, mes, ano }
enum LocationScope { pueblo, ciudad, pais }

class RankingClassificationState {
  final TimeFrame timeFrame;
  final LocationScope locationScope;
  final List<RankingUser> users;
  final bool isLoading;

  RankingClassificationState({
    this.timeFrame = TimeFrame.semana,
    this.locationScope = LocationScope.pueblo,
    this.users = const [],
    this.isLoading = false,
  });

  RankingClassificationState copyWith({
    TimeFrame? timeFrame,
    LocationScope? locationScope,
    List<RankingUser>? users,
    bool? isLoading,
  }) {
    return RankingClassificationState(
      timeFrame: timeFrame ?? this.timeFrame,
      locationScope: locationScope ?? this.locationScope,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final rankingClassificationProvider =
StateNotifierProvider<RankingClassificationNotifier, RankingClassificationState>((ref) {
  return RankingClassificationNotifier();
});

class RankingClassificationNotifier extends StateNotifier<RankingClassificationState> {
  RankingClassificationNotifier() : super(RankingClassificationState()) {
    fetchUsers();
  }

  void setTimeFrame(TimeFrame tf) {
    state = state.copyWith(timeFrame: tf);
    fetchUsers();
  }

  void setLocationScope(LocationScope ls) {
    state = state.copyWith(locationScope: ls);
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(
      isLoading: false,
      users: List.generate(15, (index) => RankingUser(
        name: index == 5 ? "Tú" : "User $index",
        imageUrl: "https://i.pravatar.cc/150?u=$index",
        rank: index + 1,
        points: 119 - index,
        streak: 7,
        isMe: index == 5,
      )),
    );
  }
}