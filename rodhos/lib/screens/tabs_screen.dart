import 'package:flutter/material.dart';

import 'cart_screen.dart';
import 'home_screen.dart';
import 'account_screen.dart';
import 'menu_screen.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Widget> _pages = [
    HomeScreen(),
    MenuScreen(),
    CartScreen(),
  ];
  int _selected = 0;

  void _selectPage(int index) {
    setState(() {
      _selected = index;
    });
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).primaryColor,
          ),
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
        ],
      ),
    );
  }
}
