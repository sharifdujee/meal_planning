import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../core/utils/image_path.dart';
import '../model/ranking_user.dart';

// --- Enums with Extension for Spanish labels ---
enum TimeFrame { semana, mes, ano }
enum LocationScope { pueblo, ciudad, pais }

extension TimeFrameX on TimeFrame {
  String get label => {
    TimeFrame.semana: "Semana",
    TimeFrame.mes: "Mes",
    TimeFrame.ano: "Año",
  }[this]!;
}

extension LocationScopeX on LocationScope {
  String get label => {
    LocationScope.pueblo: "Pueblo",
    LocationScope.ciudad: "Ciudad",
    LocationScope.pais: "País",
  }[this]!;
}

// --- State Definition ---
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

// --- Provider ---
final classificationProvider =
StateNotifierProvider<ClassificationNotifier, ClassificationState>((ref) {
  return ClassificationNotifier();
});

// --- Notifier Implementation ---
class ClassificationNotifier extends StateNotifier<ClassificationState> {
  ClassificationNotifier() : super(ClassificationState()) {
    fetchUsers();
  }

  void setTimeFrame(TimeFrame tf) {
    if (state.timeFrame == tf) return;
    state = state.copyWith(timeFrame: tf);
    fetchUsers();
  }

  void setLocationScope(LocationScope ls) {
    if (state.locationScope == ls) return;
    state = state.copyWith(locationScope: ls);
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true);

    // ⏳ Simulating network request
    await Future.delayed(const Duration(milliseconds: 600));

    // Your specific data set
    final List<RankingUser> mockData = [
      RankingUser(name: 'Carlos García', imageUrl: ImagePath.user_1, rank: 1, points: 119, streak: 7),
      RankingUser(name: 'María López', imageUrl: ImagePath.user_2, rank: 2, points: 108, streak: 7),
      RankingUser(name: 'Alejandro Martin', imageUrl: ImagePath.user_3, rank: 3, points: 108, streak: 7),
      RankingUser(name: 'Lucia Fernández', imageUrl: ImagePath.user_4, rank: 4, points: 95, streak: 7),
      RankingUser(name: 'Roberto Ruiz', imageUrl: ImagePath.user_5, rank: 5, points: 82, streak: 7),
      RankingUser(name: 'Tú', imageUrl: ImagePath.user_6, rank: 6, points: 48, streak: 7, isMe: true),
    ];

    // Mock filtering based on scope
    List<RankingUser> results = List.from(mockData);
    if (state.locationScope == LocationScope.pueblo) {
      results = mockData.where((u) => u.rank >= 4 || u.isMe).toList();
    }

    if (mounted) {
      state = state.copyWith(
        isLoading: false,
        users: results,
      );
    }
  }
}