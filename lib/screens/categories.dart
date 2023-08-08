import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widegts/category_grid_item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeals});
  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 300,
        ),
        lowerBound: 0,
        upperBound: 1 // It is default
        );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selecteScreen(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      ),
      builder: (context, child) => SlideTransition(
        position:
            Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0)).animate(
          CurvedAnimation(
              parent: _animationController, curve: Curves.easeInOut),
        ),
        child: child,
      ),
    );
  }
}
