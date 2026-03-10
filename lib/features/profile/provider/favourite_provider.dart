
// lib/providers/favorites_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State: a map of muscleGroupId -> favorite exercise name
class FavoritesNotifier extends Notifier<Map<String, String>> {
  @override
  Map<String, String> build() {
    // Initial state: two pre-set favorites matching the screenshot
    return {
      'pecho': 'Press de banca con mancuernas',
      'espalda': 'Dominadas',
    };
  }

  /// Set (or replace) a favorite exercise for a muscle group
  void setFavorite(String groupId, String exercise) {
    state = {...state, groupId: exercise};
  }

  /// Remove a favorite for a muscle group
  void removeFavorite(String groupId) {
    final updated = Map<String, String>.from(state);
    updated.remove(groupId);
    state = updated;
  }

  /// Check if all groups have a favorite
  bool get isComplete => state.length == 6;
}

/// The main favorites provider
final favoritesProvider =
NotifierProvider<FavoritesNotifier, Map<String, String>>(
  FavoritesNotifier.new,
);

/// Convenience: get favorite for a specific group (nullable)
final groupFavoriteProvider =
Provider.family<String?, String>((ref, groupId) {
  return ref.watch(favoritesProvider)[groupId];
});

/// Derived: count of filled favorites
final favoritesCountProvider = Provider<int>((ref) {
  return ref.watch(favoritesProvider).length;
});

/// Derived: completion progress 0.0 -> 1.0
final favoritesProgressProvider = Provider<double>((ref) {
  final count = ref.watch(favoritesCountProvider);
  return count / 6.0;
});

/// Derived: whether all favorites are set
final allFavoritesSetProvider = Provider<bool>((ref) {
  return ref.watch(favoritesCountProvider) == 6;
});