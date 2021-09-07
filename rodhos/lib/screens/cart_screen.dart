import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../providers/auth.dart';
import '../providers/previous_orders.dart';
import '../widgets/main_drawer.dart';
import '../widgets/cart_panel.dart';
import '../widgets/cart_total_box.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final deliveryCharge = 4.99;
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<Order>(context);
    final mQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildHeader(),
                Container(
                  child: order.orderItems.length == 0
                      ? Center(
                          child: Text(
                            'Your cart is empty!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (c, i) {
                            return CartPanel(order.orderItems[i]);
                          },
                          itemCount: order.orderItems.length,
                        ),
                  height: mQuery.size.height * 0.49,
                ),
              ],
            ),
            _buildTotalSection(order, mQuery, () async {
              if (order.orderItems.length == 0) {
                return;
              }
              var totalPrice =
                  (order.subTotal() * 1.06 + deliveryCharge).toStringAsFixed(2);
              await order.placeOrder(context, totalPrice);
              setState(() {
                //Provider.of<Auth>(context, listen: false).newOrder();
              });
              print("cart screen total $totalPrice");
              Provider.of<Order>(context, listen: false).fetchOrders(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(order, mQuery, onTap) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CartTotalBox('SubTotal', order.subTotal()),
          CartTotalBox('Taxes', order.subTotal() * 0.06),
          CartTotalBox('Delivery', deliveryCharge),
          CartTotalBox('Grand Total', order.subTotal() * 1.06 + deliveryCharge),
          _buildOrderButton(onTap),
        ],
      ),
      height: mQuery.size.height * 0.25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        //color: Colors.grey.shade300,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildOrderButton(onTap) {
    return ElevatedButton(
      onPressed: onTap,
      child: Text(
        'Place Order',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: Colors.redAccent.shade100,
        side: BorderSide(
          color: Colors.white,
          width: 1,
        ),
        //textStyle: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              'Dish',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 45,
          ),
          Expanded(
            child: Text(
              'Quantity',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Price',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
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
    );
  }
}
