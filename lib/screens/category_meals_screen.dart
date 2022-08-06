import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category_meals';
  final List<Meal> availableMeals;
  const CategoryMealsScreen({Key? key, required this.availableMeals,}) : super(key: key);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String? categoryTitle;
  late List<Meal> displayedMeals;
  var _loadInitData = false;

  @override
  void initState() {

    super.initState();
  }
  @override
  void didChangeDependencies() {
    if(!_loadInitData) {
      final routeArgs = ModalRoute
          .of(context)
          ?.settings
          .arguments as Map<String, String>;
      final categoryId = routeArgs['id'];
      categoryTitle = routeArgs['title'];
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _loadInitData = true;
    }
    super.didChangeDependencies();
  }

  /*void _removeMeal(dynamic mealId){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id == mealId);
    });
  }*/

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
            id: displayedMeals[index].id,
            // removeItem: _removeMeal,

          );
        },
        itemCount: displayedMeals.length,
      ),
    );
  }
}
