import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String text;
  int fontSize;
  bool isUnderLine;
  bool isCeaser;
  TextWidget({
    Key? key,
    required this.text,
    required this.fontSize,
    this.isUnderLine = false,
    this.isCeaser = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: 3, // space between underline and text
      ),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: isUnderLine
            ? Color(0xFF363f93)
            : Color(0xFFffffff), // Text colour here
        width: 1.0, // Underline width
      ))),
      child: Text(
        this.text,
        style: TextStyle(
          fontSize: this.fontSize.toDouble(),
          fontFamily: isCeaser ? 'Ceaser' : "Avenir",
          fontWeight: FontWeight.w900,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
