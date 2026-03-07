
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter/material.dart';
import '../modal/active_module.dart';
import '../modal/user_profile.dart';


class ProfileState {
  final UserProfile profile;
  final List<ActiveModule> modules;
  final bool hasCustomPlan;
  final bool isLoading;

  const ProfileState({
    required this.profile,
    required this.modules,
    required this.hasCustomPlan,
    this.isLoading = false,
  });

  ProfileState copyWith({
    UserProfile? profile,
    List<ActiveModule>? modules,
    bool? hasCustomPlan,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      modules: modules ?? this.modules,
      hasCustomPlan: hasCustomPlan ?? this.hasCustomPlan,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ─── Notifier ──────────────────────────────────────────────────────────────

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
      : super(ProfileState(
    profile: const UserProfile(
      name: 'Roberto Adán',
      subscriptionType: 'PRO (Prueba)',
      isSubscriptionActive: true,
    ),
    modules: [
      ActiveModule(
        title: 'Entrenamiento',
        subtitle: 'Planes de entrenamiento personalizados',
        icon: Icons.fitness_center,
        iconColor: const Color(0xFF469271),
        isEnabled: true,
      ),
      ActiveModule(
        title: 'Nutrición',
        subtitle: 'Planes de comidas y lista de compras',
        icon: Icons.restaurant_menu,
        iconColor: const Color(0xFF469271),
        isEnabled: true,
      ),
      ActiveModule(
        title: 'Seguimiento de macronutrientes',
        subtitle: 'Ver calorías y macronutrientes por comida',
        icon: Icons.bar_chart,
        iconColor: const Color(0xFF469271),
        isEnabled: false,
      ),
    ],
    hasCustomPlan: false,
  ));

  void toggleModule(int index) {
    final updatedModules = [...state.modules];
    updatedModules[index] = ActiveModule(
      title: updatedModules[index].title,
      subtitle: updatedModules[index].subtitle,
      icon: updatedModules[index].icon,
      iconColor: updatedModules[index].iconColor,
      isEnabled: !updatedModules[index].isEnabled,
    );
    state = state.copyWith(modules: updatedModules);
  }

  void addCustomPlan() {
    state = state.copyWith(hasCustomPlan: true);
  }

  void updateProfile(UserProfile profile) {
    state = state.copyWith(profile: profile);
  }
}

// ─── Providers ─────────────────────────────────────────────────────────────

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});