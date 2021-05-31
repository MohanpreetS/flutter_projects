import 'package:flutter/material.dart';

import './dish_item.dart';

class Dishes with ChangeNotifier {
  List<DishItem> _dishes = [
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
    DishItem(
      title: 'Hummus',
      description:
          'Pureed chick peas, oil, and garlic spread, served with pita',
      price: 4.95,
      category: 'Appetizers',
    ),
  ];

  List<DishItem> get dishes {
    return [..._dishes];
  }
}
