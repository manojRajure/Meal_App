import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widegts/meal_item.dart';

class MealsScreens extends StatelessWidget {
  const MealsScreens({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });
  final void Function(Meal meal) onToggleFavorite;

  void selecteMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  final String? title;
  final List<Meal> meals;
  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh .......nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Try selecting a different category!',
          )
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = Center(
        child: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
            meal: meals[index],
            onSelecteMeal: (meal) {
              selecteMeal(context, meal);
            },
          ),
        ),
      );
    }
    if (title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
