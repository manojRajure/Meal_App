import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widegts/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  void _selecteScreen(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meals) => meals.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => MealsScreens(
                title: category.title,
                meals: filteredMeals,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        // availableCategories.map((category) =>CategoryGridItem(category: category)).toList()
        for (final categorys in availableCategories)
          CategoryGridItem(
            category: categorys,
            onSelecteCategory: () => _selecteScreen(context, categorys),
          ),
      ],
    );
  }
}
