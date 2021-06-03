import './dish_item.dart';

class OrderItem {
  DishItem dish;
  int quantity;
  String orderItemId;

  OrderItem({
    required this.dish,
    required this.quantity,
    required this.orderItemId,
  });
}
