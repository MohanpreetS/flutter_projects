import 'package:flutter/material.dart';

import './categories_screen.dart';
import 'favorites_screen.dart';
import '../widgets/main_drawer.dart';
import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favMeals;

  TabsScreen(this.favMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {'page': CategoriesScreen(), 'title': 'Categories'},
      {'page': FavouritesScreen(widget.favMeals), 'title': 'Favs'}
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pages[_selectedIndex]['title']),
      ),
      drawer: MainDrawer(),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        currentIndex: _selectedIndex,
        //type: BottomNavigationBarType.shifting,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            title: Text(
              'Categories',
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.star),
            title: Text(
              'Favs',
            ),
          ),
        ],
      ),
    );
  }
}
