import 'package:flutter/material.dart';
import 'package:rodhos/widgets/main_drawer.dart';

class AccountScreen extends StatefulWidget {
  static const routeName = '/AccountScreen';
  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Rodhos'),
      ),
      body: Center(
        child: Text('Account'),
      ),
    );
  }
}
