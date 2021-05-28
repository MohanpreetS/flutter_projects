import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import 'product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  var showFavsOnly = false;
  String _authToken;
  String _userId;

  set setAuthToken(String val) {
    _authToken = val;
  }

  Products(this._authToken, this._userId, this._items);

  List<Product> get favouriteItems {
    return _items.where((element) => element.isFavourite).toList();
  }

  List<Product> get items {
    if (showFavsOnly) {
      return _items.where((x) => x.isFavourite).toList();
    } else {
      return [..._items];
    }
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  void showAll() {
    showFavsOnly = false;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/products.json?auth=$_authToken');
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'imageUrl': product.imageUrl,
          'price': product.price,
          'creatorId': _userId,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> updateProduct(String id, Product n) async {
    final url = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken');
    final myInd = _items.indexWhere((element) => element.id == id);
    if (myInd >= 0) {
      await http.patch(
        url,
        body: json.encode({
          'title': n.title,
          'description': n.description,
          'imageUrl': n.imageUrl,
          'price': n.price,
        }),
      );
      _items[myInd] = n;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken');
    final existingProductIndex =
        _items.indexWhere((element) => element.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final resp = await http.delete(url);

    if (resp.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product');
    } else {
      existingProduct = null;
    }
  }

  Future<void> fetchSet([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="creatorId"&equalTo="$_userId"' : '';
    final url = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/products.json?auth=$_authToken&$filterString');
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    final List<Product> loadedProducts = [];
    if (extractedData == null) {
      return;
    }
    final url2 = Uri.parse(
        'https://flutter-update-b73bf-default-rtdb.firebaseio.com/userFavorites/$_userId.json?auth=$_authToken');
    final favoriteResponse = await http.get(url2);
    final favData = json.decode(favoriteResponse.body);
    extractedData.forEach((key, value) {
      loadedProducts.add(Product(
        id: key,
        description: value['description'],
        price: value['price'],
        imageUrl: value['imageUrl'],
        title: value['title'],
        isFavourite: favData == null ? false : favData[key] ?? false,
      ));
    });
    _items = loadedProducts;
    notifyListeners();
  }
}
