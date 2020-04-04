import 'package:deli_meals/widgets/meal_item.dart';
import 'package:flutter/material.dart';
import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> _availableMeals;

  static const routeName = '/category-meals';

CategoryMealsScreen(this._availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadedData = false;
  // @override
  // void initState() {
  //   //we cant do anything related to context in initState becoz it run very early
  //   //alternative is didChangeDependencies
  //   // final routeArgs =
  //   //     ModalRoute.of(context).settings.arguments as Map<String, String>;
  //   //  categoryTitle = routeArgs['title'];
  //   // final categoryId = routeArgs['id'];
  //   //  displayedMeals = DUMMY_MEALS.where((meal) {
  //   //   return meal.categories.contains(categoryId);
  //   // }).toList();
  //   super.initState();
  // }
  @override
  void didChangeDependencies() {
    if(!_loadedData){
     final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
     categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
     displayedMeals = widget._availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    _loadedData = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String Id) {
    setState(() {
      displayedMeals.removeWhere((meal) {
        return meal.id == Id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayedMeals[index].id,
              title: displayedMeals[index].title,
              duration: displayedMeals[index].duration,
              imageUrl: displayedMeals[index].imageUrl,
              affordability: displayedMeals[index].affordability,
              complexity: displayedMeals[index].complexity,
            );
          },
          itemCount: displayedMeals.length,
        ));
  }
}
