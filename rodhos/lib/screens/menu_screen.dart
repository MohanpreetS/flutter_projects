import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class MenuScreen extends StatefulWidget {
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
      body: Center(
        child: Text('Menu'),
      ),
    );
  }
}
