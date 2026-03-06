

import 'package:flutter_riverpod/legacy.dart';

class OnboardingState {
  final int step; // 0-6
  // Step 0 - Goals
  final List<String> selectedGoals;
  // Step 1 - User info
  final double height; // cm
  final double weight; // kg
  final double targetWeight; // kg
  final int age;
  final String sex; // 'M' | 'F'
  // Step 2 - Level
  final String? fitnessLevel; // principiante | intermedio | avanzado
  // Step 3 - Plan
  final String? planType; // personalizado | estandar
  // Step 4 - Training days
  final String? trainingDays; // 2-3 | 3-4 | 5+
  // Step 6 - Account
  final String email;
  final String password;
  final bool passwordVisible;

  const OnboardingState({
    this.step = 0,
    this.selectedGoals = const [],
    this.height = 170,
    this.weight = 70,
    this.targetWeight = 65,
    this.age = 25,
    this.sex = 'M',
    this.fitnessLevel,
    this.planType,
    this.trainingDays,
    this.email = '',
    this.password = '',
    this.passwordVisible = false,
  });

  OnboardingState copyWith({
    int? step,
    List<String>? selectedGoals,
    double? height,
    double? weight,
    double? targetWeight,
    int? age,
    String? sex,
    String? fitnessLevel,
    String? planType,
    String? trainingDays,
    String? email,
    String? password,
    bool? passwordVisible,
  }) =>
      OnboardingState(
        step: step ?? this.step,
        selectedGoals: selectedGoals ?? this.selectedGoals,
        height: height ?? this.height,
        weight: weight ?? this.weight,
        targetWeight: targetWeight ?? this.targetWeight,
        age: age ?? this.age,
        sex: sex ?? this.sex,
        fitnessLevel: fitnessLevel ?? this.fitnessLevel,
        planType: planType ?? this.planType,
        trainingDays: trainingDays ?? this.trainingDays,
        email: email ?? this.email,
        password: password ?? this.password,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}

// ─────────────────────────────────────────────
// NOTIFIER
// ─────────────────────────────────────────────
class OnboardingNotifier extends StateNotifier<OnboardingState> {
  OnboardingNotifier() : super(const OnboardingState());

  void nextStep() {
    if (state.step < 7) state = state.copyWith(step: state.step + 1);
  }

  void prevStep() {
    if (state.step > 0) state = state.copyWith(step: state.step - 1);
  }

  void toggleGoal(String goal) {
    final goals = List<String>.from(state.selectedGoals);
    if (goals.contains(goal)) {
      goals.remove(goal);
    } else {
      goals.add(goal);
    }
    state = state.copyWith(selectedGoals: goals);
  }

  void setHeight(double v) => state = state.copyWith(height: v);
  void setWeight(double v) => state = state.copyWith(weight: v);
  void setAge(int v) => state = state.copyWith(age: v);
  void setFitnessLevel(String v) => state = state.copyWith(fitnessLevel: v);
  void setPlanType(String v) => state = state.copyWith(planType: v);
  void setTrainingDays(String v) => state = state.copyWith(trainingDays: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void togglePasswordVisible() =>
      state = state.copyWith(passwordVisible: !state.passwordVisible);

  // Add these methods inside your OnboardingNotifier class:

  void setSex(String sex) => state = state.copyWith(sex: sex);

  void setTargetWeight(double targetWeight) =>
      state = state.copyWith(targetWeight: targetWeight);
}

final onboardingProvider =
StateNotifierProvider<OnboardingNotifier, OnboardingState>(
      (ref) => OnboardingNotifier(),
);