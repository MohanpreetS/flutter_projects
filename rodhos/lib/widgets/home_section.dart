import 'dart:io';

import 'package:flutter/material.dart';

import './home_section_item.dart';

class HomeSection extends StatefulWidget {
  final Color color;
  final Color nextColor;
  final bool bottomBorder;

  const HomeSection({
    required this.color,
    required this.nextColor,
    required this.bottomBorder,
  });

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Container(
      color: widget.nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)),
        ),
        padding: EdgeInsets.only(
          top: 30.0,
          left: 4,
          bottom: Platform.isIOS ? 35 : 25,
        ),
        height: Platform.isIOS
            ? mQuery.size.height * 0.18
            : mQuery.size.height * 0.2,
        child: ListView(
          scrollDirection: Axis.horizontal,
          clipBehavior: Clip.none,
          children: [
            HomeSectionItem(color: widget.color, nextColor: widget.nextColor),
            HomeSectionItem(color: widget.color, nextColor: widget.nextColor),
            HomeSectionItem(color: widget.color, nextColor: widget.nextColor),
            HomeSectionItem(color: widget.color, nextColor: widget.nextColor),
            HomeSectionItem(color: widget.color, nextColor: widget.nextColor)
          ],
        ),
      ),
    );
  }
}
