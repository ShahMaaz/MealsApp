import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/filter.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tabs_screen.dart';

import 'models/meal.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Filter _filters = Filter();
  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Filter filterData){
    setState(() {
    _filters = filterData;
    _availableMeals = DUMMY_MEALS.where((meal) {
      if(_filters.gluten && !meal.isGlutenFree){
        return false;
      }
      if(_filters.lactose && !meal.isLactoseFree){
        return false;
      }
      if(_filters.vegetarian && !meal.isVegetarian){
        return false;
      }
      if(_filters.vegan && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();
    });
  }

  void _toggleFavorite(String mealID){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealID);
    setState(() {
      if(existingIndex >= 0){
        _favoriteMeals.removeAt(existingIndex);
      }else{
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID),);
      }
    });
  }

  bool isMealFavorite(String id){
    return _favoriteMeals.any((meal) => meal.id == id);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            bodyText2: const TextStyle(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
            headline1: const TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold)),
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(
          secondary: Colors.amber,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(favoriteMeals: _favoriteMeals,),
        CategoryMealsScreen.routeName: (context) => CategoryMealsScreen(availableMeals: _availableMeals,),
        MealDetailsScreen.routeName: (context) => MealDetailsScreen(toggleFavorite: _toggleFavorite, isFavorite: isMealFavorite,),
        FiltersScreen.routName: (context) => FiltersScreen(saveFilters: _setFilters, currentFilters: _filters,),
      },
     /* onGenerateRoute: (settings) {
        print('Maz Shah ${settings.name}');
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      },*/
      /*onUnknownRoute: (settings){
        return MaterialPageRoute(
          builder: (context) => const CategoryScreen(),
        );
      },*/
    );
  }
}
