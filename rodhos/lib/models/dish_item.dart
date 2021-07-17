enum Size {
  small,
  medium,
  large,
}

class DishItem {
  final String title;
  final String description;
  final double mediumPrice;
  final String category;
  bool isMultiSize;
  var size = Size.medium;
  double largePrice;
  double smallPrice;

  DishItem({
    required this.title,
    required this.description,
    required this.mediumPrice,
    required this.category,
    required this.largePrice,
    required this.smallPrice,
    this.isMultiSize = false,
  });

  double get price {
    if (size == Size.small) {
      return smallPrice;
    } else if (size == Size.medium) {
      return mediumPrice;
    } else if (size == Size.large) {
      return largePrice;
    }
    return mediumPrice;
  }

  void changeSize(Size x) {
    if (isMultiSize) {
      size = x;
    }
  }
}
