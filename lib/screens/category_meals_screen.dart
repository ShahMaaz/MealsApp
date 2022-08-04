import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals';

  const CategoryMealsScreen({Key? key}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  late List<Meal> displayedMeals;
  var loadInitData = false;

  @override
  void initState() {

    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!loadInitData) {
      final routeArgs = ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      loadInitData = true;
    }
    super.didChangeDependencies();
  }

  void removeItem(String mealId){
    setState(() {
      displayedMeals.where((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItem(
            complexity: displayedMeals[index].complexity,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            title: displayedMeals[index].title,
            id: displayedMeals[index].id, removeItem: (String ) {  },
          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
