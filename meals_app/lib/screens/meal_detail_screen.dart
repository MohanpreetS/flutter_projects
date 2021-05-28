import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreeen extends StatelessWidget {
  static const routeName = '/MealDetailScreen';

  final Function toggleFav;
  final Function isFav;

  MealDetailScreeen(this.toggleFav, this.isFav);

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments;
    final selectedMeal = DUMMY_MEALS.firstWhere((x) => x.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedMeal.title}'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectedMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(ctx).accentColor,
                  child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: Text(selectedMeal.ingredients[index])),
                ),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (ctx, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${index + 1}'),
                        ),
                        title: Text(selectedMeal.steps[index]),
                      ),
                      Divider(
                        color: Colors.black54,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isFav(mealId) ? Icons.star : Icons.star_border),
        onPressed: () => toggleFav(mealId),
      ),
    );
  }
}
