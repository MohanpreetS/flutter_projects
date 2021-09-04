import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/dish_item.dart';
import '../models/order_item.dart';
import '../providers/auth.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orderItems = [];
  String orderId;
  //final BuildContext context;

  Order(this.orderId);

  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  void addToOrder(
      {required DishItem dishItem,
      required int qty,
      required Size size,
      request = ''}) {
    _orderItems.add(OrderItem(
      id: dishItem.id,
      category: dishItem.category,
      description: dishItem.description,
      isMultiSize: dishItem.isMultiSize,
      largePrice: dishItem.largePrice,
      mediumPrice: dishItem.mediumPrice,
      smallPrice: dishItem.smallPrice,
      title: dishItem.title,
      quantity: qty,
      orderItemId: UniqueKey().toString(),
      size: size,
      request: request,
    ));
    notifyListeners();
  }

  String calcSize(Size x) {
    if (x == Size.large) {
      return "L";
    } else if (x == Size.medium) {
      return "M";
    } else if (x == Size.small) {
      return "S";
    }
    return "M";
  }

  void placeOrder(context) async {
    final auth = Provider.of<Auth>(context, listen: false);
    int? orderId = auth.activeOrderId;
    for (var order in _orderItems) {
      final url = "https://rodhosapi.herokuapp.com/dishes/orders/$orderId/add";
      final size = calcSize(order.size);
      await http.post(Uri.parse(url),
          body: json.encode(
            {
              "quantity": order.quantity,
              "size": size,
              "dish": order.id,
            },
          ),
          headers: {
            "Authorization": "token ${auth.token}",
            'Content-type': 'application/json',
          });
    }
  }

  void editOrderItem(orderItemId, qty, request, size) {
    var ind =
        _orderItems.indexWhere((element) => element.orderItemId == orderItemId);
    _orderItems[ind].quantity = qty;
    _orderItems[ind].request = request;
    _orderItems[ind].size = size;
    notifyListeners();
  }

  void increaseCount(String orderItemId) {
    int index =
        _orderItems.indexWhere((element) => element.orderItemId == orderItemId);
    _orderItems[index].quantity++;
    print(_orderItems[index].request);
    notifyListeners();
  }

  void decreaseCount(String orderItemId) {
    int index =
        _orderItems.indexWhere((element) => element.orderItemId == orderItemId);
    if (_orderItems[index].quantity == 1) {
      _orderItems.removeAt(index);
    } else {
      _orderItems[index].quantity--;
    }
    notifyListeners();
  }

  double subTotal() {
    double sub = 0;
    orderItems.forEach((element) {
      sub += element.price * element.quantity;
    });
    return sub;
  }
}
