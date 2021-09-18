import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/dish_item.dart';

class Dishes with ChangeNotifier {
  List<DishItem> _dishes = [];

  List<DishItem> get dishes {
    return [..._dishes];
  }

  //Uri.https('rodhosapi2.herokuapp.com', 'dishes')
  Future<void> fetchData() async {
    var response = await http
        .get(Uri.parse('https://rodhosapi.herokuapp.com/dishes/list/'));
    var jsonData = jsonDecode(response.body);
    if (_dishes.isEmpty) {
      //print('getting it');
      for (var x in jsonData) {
        if (x['category'] == 'Rodhos Pizza' || x['category'] == 'Pizza') {
          DishItem dish = DishItem(
            id: x['id'],
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
            id: x['id'],
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
    notifyListeners();
  }
}
