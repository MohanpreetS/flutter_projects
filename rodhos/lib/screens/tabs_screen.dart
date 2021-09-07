import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'orders_screen.dart';
import 'menu_screen.dart';
import '../providers/dishes.dart';

class TabsScreen extends StatefulWidget {
  int selected = 0;

  TabsScreen(this.selected);
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _pages = [
    //HomeScreen(),
    MenuScreen(),
    CartScreen(),
    OrdersScreen(),
  ];
  int _selected = 0;

  void _selectPage(int index) {
    setState(() {
      widget.selected = index;
      _selected = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectPage(widget.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selected],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selected,
        onTap: _selectPage,
        // backgroundColor: Theme.of(context).primaryColor,
        items: [
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          //   backgroundColor: Theme.of(context).primaryColor,
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            label: 'Menu',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Cart',
            backgroundColor: Theme.of(context).primaryColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Orders',
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}
