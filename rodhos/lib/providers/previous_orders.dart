import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './order.dart';

class PreviousOrders with ChangeNotifier {
  List<Order> orders = [];

  Future<void> fetchOrders() async {
    const orderUrl = "https://rodhosapi.herokuapp.com/dishes/orders/";
    final orderResponse = await http.get(Uri.parse(orderUrl));
    final orderList = json.decode(orderResponse.body);
    print(orderList);
  }
}
