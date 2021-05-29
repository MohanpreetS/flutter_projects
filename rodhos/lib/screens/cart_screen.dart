import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(
        child: Text('Cart'),
      ),
    );
  }
}
