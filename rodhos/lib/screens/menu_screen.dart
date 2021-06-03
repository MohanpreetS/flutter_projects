import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../models/dish_item.dart';
import '../providers/dishes.dart';
import '../widgets/main_drawer.dart';
import '../widgets/category_filter.dart';
import '../widgets/dish_tile.dart';
import '../widgets/menu_filters.dart';
import '../screens/cart_screen.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/MenuScreen';
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    final menuItems = Provider.of<Dishes>(context).dishes;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Menu'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              size: 23,
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          StickyHeader(
            header: MenuFilters(),
            content: StickyHeader(
              header: Container(
                margin: EdgeInsets.only(top: 5),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.035,
                child: Text(
                  'Appetizers',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              content: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: menuItems.length,
                itemBuilder: (c, i) => DishTile(
                  title: menuItems[i].title,
                  description: menuItems[i].description,
                  price: menuItems[i].price,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
