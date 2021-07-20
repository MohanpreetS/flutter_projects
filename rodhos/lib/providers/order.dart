import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../models/dish_item.dart';
import '../models/order_item.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orderItems = [];
  String orderId;

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
    print(request);
    notifyListeners();
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
