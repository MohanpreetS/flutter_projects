import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widgets/main_drawer.dart';
import '../widgets/cart_panel.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<Order>(context);
    final mQuery = MediaQuery.of(context);
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        child: Text(
                      'Dish',
                      style: TextStyle(fontSize: 16),
                    )),
                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Text(
                      'Price',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 5,
                    ),
                  ),
                ),
              ),
              Container(
                child: ListView.builder(
                  itemBuilder: (c, i) {
                    return CartPanel(order.orderItems[i]);
                  },
                  itemCount: order.orderItems.length,
                ),
                height: mQuery.size.height * 0.58,
              ),
            ],
          ),
          Container(
            height: mQuery.size.height * 0.15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Colors.grey.shade300,
            ),
          )
        ],
      ),
    );
  }
}
