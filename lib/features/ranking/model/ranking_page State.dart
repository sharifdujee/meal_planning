enum RankingTab { compite, clasificaciones }

class UserRank {
  final String id;
  final String name;
  final int score;
  final int rank;
  final String? streak;
  final String userAvater;

  UserRank({
    required this.id,
    required this.name,
    required this.score,
    required this.rank,
    this.streak,
    required this.userAvater,
  });
}

class RankingPageState {
  final List<UserRank> users;
  final RankingTab activeTab;
  final bool isPrivateLeagueEnabled; // 1. Added the field

  RankingPageState({
    required this.users,
    required this.activeTab,
    required this.isPrivateLeagueEnabled, // 2. Required in constructor
  });

  RankingPageState copyWith({
    List<UserRank>? users,
    RankingTab? activeTab,
    bool? isPrivateLeagueEnabled, // 3. Added to copyWith parameters
  }) {
    return RankingPageState(
      users: users ?? this.users,
      activeTab: activeTab ?? this.activeTab,
      // 4. Correctly passing the value instead of null
      isPrivateLeagueEnabled: isPrivateLeagueEnabled ?? this.isPrivateLeagueEnabled,
    );
  }
}