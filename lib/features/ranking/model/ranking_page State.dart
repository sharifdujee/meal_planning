enum RankingTab { compite, clasificaciones }

class UserRank {
  final String id;
  final String name;
  final int score;
  final int rank;
  final String? streak;

  UserRank({
    required this.id,
    required this.name,
    required this.score,
    required this.rank,
    this.streak,
  });
}

class RankingPageState {
  final List<UserRank> users;
  final RankingTab activeTab;
  final bool isPrivateLeagueEnabled;

  RankingPageState({
    required this.users,
    required this.activeTab,
    required this.isPrivateLeagueEnabled,
  });

  RankingPageState copyWith({
    List<UserRank>? users,
    RankingTab? activeTab,
    bool? isPrivateLeagueEnabled,
  }) {
    return RankingPageState(
      users: users ?? this.users,
      activeTab: activeTab ?? this.activeTab,
      isPrivateLeagueEnabled:
      isPrivateLeagueEnabled ?? this.isPrivateLeagueEnabled,
    );
  }
}