import 'package:flutter/material.dart';

import '../models/dish_item.dart';
import '../models/order_item.dart';

class Order with ChangeNotifier {
  List<OrderItem> _orderItems = [
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 3,
    //   orderItemId: 'o1',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 4,
    //   orderItemId: 'o2',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 5,
    //   orderItemId: 'o3',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 2,
    //   orderItemId: 'o4',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 2,
    //   orderItemId: 'o5',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 2,
    //   orderItemId: 'o6',
    // ),
    // OrderItem(
    //   dish: DishItem(
    //     title: 'Hummus',
    //     description:
    //         'Pureed chick peas, oil, and garlic spread, served with pita',
    //     price: 4.95,
    //     category: 'Appetizers',
    //   ),
    //   quantity: 2,
    //   orderItemId: 'o7',
    // )
  ];
  String orderId;

  Order(this.orderId);

  List<OrderItem> get orderItems {
    return [..._orderItems];
  }

  void addToOrder(DishItem dishItem, int qty) {
    _orderItems.add(OrderItem(
      dish: dishItem,
      quantity: qty,
      orderItemId: UniqueKey().toString(),
    ));
    notifyListeners();
  }

  void increaseCount(String orderItemId) {
    int index =
        _orderItems.indexWhere((element) => element.orderItemId == orderItemId);
    _orderItems[index].quantity++;
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
      sub += element.dish.price * element.quantity;
    });
    return sub;
  }
}
