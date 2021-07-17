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
        if (x['category'] == 'Rodhos Pizza' || x['category'] == 'Pizza') {
          DishItem dish = DishItem(
            title: x['title'],
            description: x['description'],
            mediumPrice: double.parse(x['price'].toString()),
            category: x['category'],
            largePrice: double.parse(x['largePrice'].toString()),
            smallPrice: double.parse(x['smallPrice'].toString()),
            isMultiSize: true,
          );
          _dishes.add(dish);
        } else {
          DishItem dish = DishItem(
            title: x['title'],
            description: x['description'],
            mediumPrice: double.parse(x['price'].toString()),
            category: x['category'],
            largePrice: double.parse(x['largePrice'].toString()),
            smallPrice: double.parse(x['smallPrice'].toString()),
          );
          _dishes.add(dish);
        }
      }
    }
    print(_dishes.where((element) => element.isMultiSize).length);
  }
}
