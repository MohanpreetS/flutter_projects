import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final title;

  CategoryFilter(this.title);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        title,
        //style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
