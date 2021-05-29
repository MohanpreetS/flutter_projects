import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';
import '../widgets/category_filter.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/MenuScreen';
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Appetizers'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Indian'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Greek'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Pizza'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Pizza'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Pizza'),
                  SizedBox(
                    width: 10,
                  ),
                  CategoryFilter('Pizza'),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Theme.of(context).accentColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
          )
        ],
      ),
    );
  }
}
