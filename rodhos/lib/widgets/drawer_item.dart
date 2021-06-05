import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final label;
  final router;

  DrawerItem(this.label, this.router);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: router,
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        margin: EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 2,
        ),
        height: MediaQuery.of(context).size.height * 0.085,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            width: 2,
            color: Colors.grey.shade300,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}