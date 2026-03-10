import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/week_plan_model.dart';

class SelectPlanNotifier extends Notifier<WeekType> {

  @override
  WeekType build() => WeekType.normal;

  void setPlan(WeekType newPlan) {
    state = newPlan;
  }
}

final selectPlanProvider =
NotifierProvider<SelectPlanNotifier, WeekType>(SelectPlanNotifier.new);