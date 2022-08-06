import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoriteMeal;

  const FavoritesScreen(
      {Key? key,
      required this.favoriteMeal,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return favoriteMeal.isEmpty
        ? const Center(
            child: Text('You have no favorites yet - start adding some!'),
          )
        : ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                imageUrl: favoriteMeal[index].imageUrl,
                complexity: favoriteMeal[index].complexity,
                duration: favoriteMeal[index].duration,
                affordability: favoriteMeal[index].affordability,
                title: favoriteMeal[index].title,
                id: favoriteMeal[index].id,
              );
            },
            itemCount: favoriteMeal.length,
          );
  }
}
