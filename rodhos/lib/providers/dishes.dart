import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/dish_item.dart';

class Dishes with ChangeNotifier {
  List<DishItem> _dishes = [];

  List<DishItem> get dishes {
    fetchData();
    return [..._dishes];
  }

  Future<void> fetchData() async {
    var response =
        await http.get(Uri.https('rodhosapi2.herokuapp.com', 'dishes'));
    var jsonData = jsonDecode(response.body);
    if (_dishes.isEmpty) {
      for (var x in jsonData) {
        DishItem dish = DishItem(
          title: x['title'],
          description: x['description'],
          price: double.parse(x['price'].toString()),
          category: x['category'],
        );
        _dishes.add(dish);
      }
    }
    print(_dishes.length);
  }
}
