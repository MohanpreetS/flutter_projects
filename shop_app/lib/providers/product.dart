import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavourite = false,
  });

  Future<void> toggleFav(String token, String userId) async {
    final old = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$token');
    try {
      final resp = await http.put(
        url,
        body: json.encode(isFavourite),
      );
      if (resp.statusCode >= 400) {
        isFavourite = old;
        notifyListeners();
      }
    } catch (e) {
      isFavourite = old;
      notifyListeners();
    }
  }
}
