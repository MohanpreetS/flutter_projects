import 'dart:io';

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
  void initState() {
    Provider.of<Dishes>(context, listen: false).fetchData().then(
      (value) {
        setState(() {});
      },
    );
    super.initState();
  }

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     Provider.of<Dishes>(context).fetchData().then((value) {
  //       setState(() {});
  //     });
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

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
          onPressed: () {
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
              MenuFilters(),
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   itemCount: menuItems.length,
                        //   itemBuilder: (c, i) {
                        //     return DishTile(
                        //       dishItem: menuItems[i],
                        //     );
                        //   },
                        // ),
                        categoryList('Appetizers', menuItems),
                        categoryList('Salads', menuItems),
                        categoryList('Indian Specialities', menuItems),
                        categoryList('Seafood', menuItems),
                        categoryList('Pasta', menuItems),
                        categoryList('Combinations', menuItems),
                        categoryList('Greek Specialities', menuItems),
                        categoryList('Dessert', menuItems),
                        categoryList('Special Dinner', menuItems),
                        categoryList('Steak & Ribs', menuItems),
                        categoryList('Chicken', menuItems),
                        categoryList('Rodhos Pizza', menuItems),
                        categoryList('Pizza', menuItems),
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