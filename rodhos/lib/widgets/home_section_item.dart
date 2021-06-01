import 'package:flutter/material.dart';

class HomeSectionItem extends StatelessWidget {
  final color;
  final nextColor;

  HomeSectionItem({
    required this.color,
    required this.nextColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: nextColor,
          width: 3,
        ),
      ),
      margin: EdgeInsets.only(right: 15),
    );
  }
}
