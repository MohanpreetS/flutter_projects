import 'package:flutter/material.dart';
import 'package:rodhos/screens/tabs_screen.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/auth_screen.dart';
import '../screens/contact_screen.dart';
import './drawer_item.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1115,
            padding: EdgeInsets.all(20),
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child: Text(
              'Rodhos',
              style: TextStyle(
                //fontWeight: FontWeight.bold,
                fontSize: 28,
                //color: Colors.white,
                fontFamily: 'Ceaser',
              ),
              softWrap: true,
            ),
          ),
          Divider(),
          DrawerItem('Menu', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(0)));
          }),
          Divider(),
          DrawerItem('Cart', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(1)));
          }),
          Divider(),
          DrawerItem('Orders', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => TabsScreen(2)));
          }),
          Divider(),
          // DrawerItem('Account', () {
          //   Navigator.of(context).pushNamed(AccountScreen.routeName);
          // }),
          //DrawerItem('Favourites', FavouritesScreen.routeName),
          DrawerItem('Contact Us', () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (c) => ContactScreen()));
          }),
          Divider(),
          // DrawerItem('About Us', () {}),
          // Divider(),
          Spacer(),
          buildLogoutButton(authProvider, context),
        ],
      ),
    );
  }

  Widget buildLogoutButton(authProvider, context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        authProvider.logout();
        setState(() {});
        Navigator.of(context).pushReplacementNamed('/');
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 35),
        height: 40,
        width: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.35),
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            Text(
              "Logout",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
