import './dish_item.dart';

class OrderItem extends DishItem {
  int quantity;
  String orderItemId;
  String request;

  OrderItem({
    required id,
    required this.quantity,
    required this.orderItemId,
    required title,
    required category,
    required description,
    required largePrice,
    required mediumPrice,
    required smallPrice,
    required isMultiSize,
    size = Size.medium,
    this.request = '',
  }) : super(
          id: id,
          title: title,
          category: category,
          description: description,
          largePrice: largePrice,
          mediumPrice: mediumPrice,
          smallPrice: smallPrice,
          isMultiSize: isMultiSize,
          size: size,
        );

  void changeSize(Size x) {
    if (isMultiSize) {
      size = x;
    }
  }
}
