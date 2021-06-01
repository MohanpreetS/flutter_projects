import 'package:flutter/material.dart';

import './home_section_item.dart';

class HomeSection extends StatelessWidget {
  final Color color;
  final Color nextColor;

  const HomeSection({
    required this.color,
    required this.nextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
        ),
        padding: const EdgeInsets.only(
          top: 30.0,
          left: 4,
          bottom: 40,
        ),
        height: MediaQuery.of(context).size.height * 0.18,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            HomeSectionItem(color: color, nextColor: nextColor),
            HomeSectionItem(color: color, nextColor: nextColor),
            HomeSectionItem(color: color, nextColor: nextColor),
            HomeSectionItem(color: color, nextColor: nextColor),
            HomeSectionItem(color: color, nextColor: nextColor)
          ],
        ),
      ),
    );
  }
}
