// import 'dart:convert';

// import './dish_item.dart';
// import 'package:http/http.dart' as http;

// class ApiData {
//   Future<List<DishItem>> fetchData() async {
//     var response =
//         await http.get(Uri.https('https://rodhos-api.herokuapp.com', 'dishes'));
//     var jsonData = jsonDecode(response.body);
//     List<DishItem> dishes = [];

//     for (var apiDish in jsonData) {
//       print(apiDish['prices']['price'] is double);
//       DishItem dish = DishItem(
//         title: apiDish['title'],
//         description: apiDish['description'],
//         price: apiDish['prices'],
//         category: apiDish['category'],
//       );
//       dishes.add(dish);
//     }
//     print(dishes.length);
//     return dishes;
//   }
// }
