import 'dart:convert';

import './dish_item.dart';
import 'package:http/http.dart' as http;

class ApiData {
  Future<List<DishItem>> fetchData() async {
    var response =
        await http.get(Uri.https('https://rodhos-api.herokuapp.com', 'dishes'));
    var jsonData = jsonDecode(response.body);
    List<DishItem> dishes = [];

    for (var x in jsonData) {
      DishItem dish = DishItem(
        title: x['title'],
        description: x['description'],
        price: x['price'],
        category: x['category'],
      );
      dishes.add(dish);
    }
    print(dishes.length);
    return dishes;
  }
}
