import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/features/week/model/meal.dart';

final mealProvider = Provider<List<Meal>>((ref){
  return[
    Meal(category: "DESAYUNO", title: "Batido de bayas",imageIcon: IconPath.tea,chefName: "Ver Receta"),
    Meal(category: "ALMUERZO", title: "Camarones y quinoa",description: "Un tazón personalizable y rico en nutrientes conproteína magra y cereales integrales." ,imageIcon: IconPath.restaurant02,chefName: "Ver Receta"),
    Meal(category: "BOCADILLO", title: "Un puñado pequeño de almendras",description: "Un refrigerio saludable y saciante." ,imageIcon: IconPath.cookie,chefName: "Ver Receta"),
    Meal(title: "Brochetas De Pollo Y Verduras",description: "Brochetas ligeras y coloridas, perfectas para una cena ligeray personalizable." ,imageIcon: IconPath.moon02,chefName: "Ver Receta",),
  ];
});