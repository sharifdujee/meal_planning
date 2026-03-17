enum TimeFrame { semana, mes, ano }
enum LocationScope { pueblo, ciudad, pais }

class RankingUser {
  final String name;
  final String imageUrl;
  final int rank;
  final int points;
  final int streak;
  final bool isMe;

  RankingUser({
    required this.name,
    required this.imageUrl,
    required this.rank,
    required this.points,
    required this.streak,
    this.isMe = false,
  });
}

class ClassificationState {
  final TimeFrame timeFrame;
  final LocationScope locationScope;
  final List<RankingUser> users;
  final bool isLoading;

  ClassificationState({
    this.timeFrame = TimeFrame.semana,
    this.locationScope = LocationScope.pueblo,
    this.users = const [],
    this.isLoading = false,
  });

  ClassificationState copyWith({
    TimeFrame? timeFrame,
    LocationScope? locationScope,
    List<RankingUser>? users,
    bool? isLoading,
  }) {
    return ClassificationState(
      timeFrame: timeFrame ?? this.timeFrame,
      locationScope: locationScope ?? this.locationScope,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}