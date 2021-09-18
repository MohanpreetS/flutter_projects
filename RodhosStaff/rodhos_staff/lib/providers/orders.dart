import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:rodhos_staff/providers/http_exception.dart';

import '../providers/auth.dart';

class Orders with ChangeNotifier {
  var _previousOrders = [];
  var _currentOrders = [];
  bool isFetched;

  Orders({this.isFetched = false});

  dynamic get previousOrders {
    return [..._previousOrders];
  }

  dynamic get currentOrders {
    return [..._currentOrders];
  }

  Future<void> fetchOrders(context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    const orderUrl = 'https://rodhosapi.herokuapp.com/dishes/orders/';
    var orderList;
    try {
      final response = await http.get(
        Uri.parse(orderUrl),
        headers: {
          "Authorization": "token ${auth.token}",
          'Content-type': 'application/json',
        },
      );
      orderList = json.decode(response.body);
    } catch (err) {
      throw HttpException(err.toString());
    }

    isFetched = true;
    _previousOrders = [];
    _currentOrders = [];
    for (var order in orderList) {
      if (order["placed"] == true && order["active"] == false) {
        _previousOrders.add(order);
      }
      if (order["placed"] == true && order["active"] == true) {
        _currentOrders.add(order);
      }
    }
    notifyListeners();
    print(_previousOrders[0].runtimeType);
  }
}
