import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../model/workout_log.dart';

final workoutLogProvider = NotifierProvider<WorkoutLogNotifier, WorkoutLog>(() {
  return WorkoutLogNotifier();
});

class WorkoutLogNotifier extends Notifier<WorkoutLog> {
  Timer? _timer;

  late TextEditingController workoutNameController;
  late TextEditingController notesController;

  @override
  WorkoutLog build() {

    workoutNameController =TextEditingController();
    notesController =TextEditingController();

    workoutNameController.addListener((){
      state = state.copyWith(workoutName: workoutNameController.text);
    });

    notesController.addListener((){
      state = state.copyWith(notes: notesController.text);
    });

    ref.onDispose(() {
      _timer?.cancel();
      workoutNameController.dispose();
      notesController.dispose();
    });

    return WorkoutLog();
  }
  Future<void> selectData(BuildContext context) async{
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1999),
      lastDate: DateTime(2200),
    );
    if (picked != null){
      String formattDate = "${picked.day.toString().padLeft(2,'0')}/${picked.month.toString().padLeft(2,'0')}/${picked.year}";
      state = state.copyWith(date: formattDate);
    }
  }

  // START / RESUME
  void startTimer() {
    if (_timer?.isActive ?? false) return;

    state = state.copyWith(isTimerRunning: true);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        sessionTime: state.sessionTime + const Duration(seconds: 1),
      );
    });
  }

  // PAUSE
  void pauseTimer() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false);
  }

  // REBOOT (Reset to 0)
  void rebootTimer() {
    _timer?.cancel();
    state = state.copyWith(
      sessionTime: Duration.zero,
      isTimerRunning: false,
      isFinished: false
    );
  }

  // FINISH
  void finishWorkout() {
    _timer?.cancel();
    state = state.copyWith(isTimerRunning: false, isFinished : true);
  }

  void updateName(String name) => state = state.copyWith(workoutName: name);
  void updateNotes(String notes) => state = state.copyWith(notes: notes);
}