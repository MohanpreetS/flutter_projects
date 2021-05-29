import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Rodhos'),
      ),
      body: Center(
        child: Text('Home'),
      ),
    );
  }
}
