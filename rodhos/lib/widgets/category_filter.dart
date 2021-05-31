import 'package:flutter/material.dart';

class CategoryFilter extends StatelessWidget {
  final title;

  CategoryFilter(this.title);

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      onPressed: () => print(title),
      elevation: 8,
      label: Text(
        title,
        //style: TextStyle(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
