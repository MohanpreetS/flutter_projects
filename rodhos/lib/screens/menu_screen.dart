import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sticky_headers/sticky_headers.dart';

import '../models/dish_item.dart';
import '../providers/dishes.dart';
import '../providers/order.dart';
import '../widgets/main_drawer.dart';

import '../widgets/dish_tile.dart';
import '../widgets/menu_filters.dart';
import '../screens/cart_screen.dart';

class MenuScreen extends StatefulWidget {
  static const routeName = '/MenuScreen';
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

bool _isInit = true;

class _MenuScreenState extends State<MenuScreen> {
  // @override
  // void initState() {
  //   Provider.of<Dishes>(context, listen: false).fetchData().then(
  //     (value) {
  //       setState(() {});
  //     },
  //   );
  //   super.initState();
  // }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      await Provider.of<Order>(context, listen: false).fetchOrders(context);
      await Provider.of<Dishes>(context, listen: false).fetchData();
      setState(() {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dishProvider = Provider.of<Dishes>(context, listen: false);
    final menuItems = dishProvider.dishes;
    final mQ = MediaQuery.of(context);
    final size = mQ.size;
    final appbar = AppBar(
      title: Text('Menu'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
          },
          icon: Icon(
            Icons.shopping_cart,
            size: 23,
          ),
        ),
      ],
    );
    final appBarH = appbar.preferredSize.height;
    final statusBarHeight = mQ.padding.top;
    final actualScreenHeight = size.height - appBarH - statusBarHeight;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: appbar,
      body: SafeArea(
        child: Container(
          height: actualScreenHeight,
          child: Column(
            children: [
              MenuFilters(selectedFilters, selectFilter, resetFilters),
              Expanded(
                child: Container(
                  child: (menuItems.length == 0)
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              ...(_buildMenu(selectedFilters, menuItems)),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildMenu(Map<String, bool> selectedFilters, menuItems) {
    List<Widget> _widgetList = [];
    setState(() {
      selectedFilters.entries.forEach((entry) {
        if (entry.value) {
          _widgetList.add(categoryList(entry.key, menuItems));
        }
      });
    });
    return _widgetList;
  }

  void selectFilter(category) {
    selectedFilters.keys.forEach((key) {
      selectedFilters[key] = false;
    });
    selectedFilters[category] = true;

    setState(() {});
  }

  void resetFilters() {
    selectedFilters.keys.forEach((key) {
      selectedFilters[key] = true;
    });
    setState(() {});
  }

  Widget categoryList(category, menuItems) {
    return Column(
      children: [
        categoryTitle(category),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount:
              menuItems.where((x) => x.category == category).toList().length,
          itemBuilder: (c, i) {
            return DishTile(
              dishItem:
                  menuItems.where((x) => x.category == category).toList()[i],
            );
          },
        ),
      ],
    );
  }

  Widget categoryTitle(title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}

Map<String, bool> selectedFilters = {
  'Appetizers': true,
  'Salads': true,
  'Indian Specialities': true,
  'Seafood': true,
  'Pasta': true,
  'Combinations': true,
  'Greek Specialities': true,
  'Dessert': true,
  'Special Dinner': true,
  'Steak & Ribs': true,
  'Chicken': true,
  'Rodhos Pizza': true,
  'Pizza': true,
};



// ListView(
//         children: [
//           StickyHeader(
//             header: MenuFilters(),
//             content: StickyHeader(
//               header: Container(
//                 margin: EdgeInsets.only(top: 5),
//                 width: double.infinity,
//                 height: Platform.isIOS
//                     ? MediaQuery.of(context).size.height * 0.035
//                     : MediaQuery.of(context).size.height * 0.04,
//                 child: Text(
//                   'Appetizers',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                     color: Theme.of(context).primaryColor,
//                   ),
//                 ),
//               ),
//               content: ListView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemCount: menuItems.length,
//                 itemBuilder: (c, i) => DishTile(
//                   dishItem: menuItems[i],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),