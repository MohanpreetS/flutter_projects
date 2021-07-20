import 'package:flutter/material.dart';
import 'package:rodhos/screens/tabs_screen.dart';

import '../screens/account_screen.dart';
import '../screens/menu_screen.dart';
import '../screens/favourites_Screen.dart';
import './drawer_item.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1115,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            color: Theme.of(context).primaryColor,
            child: Text(
              'Rodhos',
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 28,
                  //color: Colors.white,
                  fontFamily: 'Ceaser'),
              softWrap: true,
            ),
          ),
          DrawerItem('Home', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(0)));
          }),
          DrawerItem('Menu', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(1)));
          }),
          DrawerItem('Cart', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(2)));
          }),
          DrawerItem('Account', () {
            Navigator.of(context).pushNamed(AccountScreen.routeName);
          }),
          //DrawerItem('Favourites', FavouritesScreen.routeName),
          DrawerItem('Contact Us', () {}),
          DrawerItem('About Us', () {}),
        ],
      ),
    );
  }
}
