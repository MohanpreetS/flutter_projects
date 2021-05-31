import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final colorList = [
      Colors.red,
      Colors.blueAccent,
      Colors.amber.shade200,
      Colors.purple.shade300,
    ];
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: Center(child: Text('cart')),
    );
  }
}
