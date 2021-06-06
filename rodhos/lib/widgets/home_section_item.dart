import 'dart:io';

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
    final mQuery = MediaQuery.of(context);
    return Container(
      height:
          Platform.isIOS ? mQuery.size.height * 0.16 : mQuery.size.height * 0.4,
      width: mQuery.size.width * 0.30,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: nextColor,
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            color: color == Colors.white
                ? Colors.grey.shade300
                : Colors.black.withOpacity(0.18),
            offset: Offset(2, 2),
            spreadRadius: 0.3,
          )
        ],
      ),
      margin: EdgeInsets.only(right: 15),
    );
  }
}
