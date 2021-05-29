import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FavouritesScreen extends StatefulWidget {
  static const routeName = '/FavouritesScreen';
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: Center(
        child: Text('Favourites'),
      ),
    );
  }
}
