import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favMeals;
  FavouritesScreen(this.favMeals);

  @override
  Widget build(BuildContext context) {
    if (favMeals.isEmpty) {
      return Center(
        child: Text('No favs'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, i) {
          return MealItem(
            id: favMeals[i].id,
            title: favMeals[i].title,
            imageUrl: favMeals[i].imageUrl,
            duration: favMeals[i].duration,
            complexity: favMeals[i].complexity,
            affordability: favMeals[i].affordability,
          );
        },
        itemCount: favMeals.length,
      );
    }
  }
}
