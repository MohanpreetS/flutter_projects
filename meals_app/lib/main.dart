import 'package:flutter/material.dart';

import './screens/categories_screen.dart';
import './screens/meal_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';
import './screens/filters_screen.dart';
import './dummy_data.dart';
import './models/meal.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;

  List<Meal> _favMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        } else if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        } else if (_filters['vegan'] && !meal.isVegan) {
          return false;
        } else if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  bool _isFav(String id) {
    return _favMeals.any((element) => element.id == id);
  }

  void _toggleFavourite(String mealId) {
    final existingIndex =
        _favMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favMeals
            .add(DUMMY_MEALS.firstWhere((element) => element.id == mealId));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
          primarySwatch: Colors.pink,
          accentColor: Colors.amber,
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
          fontFamily: 'Raleway',
          textTheme: ThemeData.light().textTheme.copyWith(
                body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                title: TextStyle(
                  fontSize: 20,
                  fontFamily: 'RobotoCondensed',
                  fontWeight: FontWeight.bold,
                ),
              )),
      //home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(_favMeals),
        MealScreen.routeName: (ctx) => MealScreen(_availableMeals),
        MealDetailScreeen.routeName: (ctx) =>
            MealDetailScreeen(_toggleFavourite, _isFav),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_setFilters, _filters),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
