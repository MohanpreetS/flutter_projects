import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../widgets/main_drawer.dart';
import '../widgets/order_card.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/OrdersScreen';
  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  static const routeName = '/OrdersScreen';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final orderProvider = Provider.of<Order>(context);
    var prevOrders = orderProvider.previousOrders;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            _buildTitle("Current Orders"),
            SizedBox(
              height: 20,
            ),
            _buildTitle("Previous Orders"),
            ..._buildPreviousOrders(prevOrders).reversed,
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPreviousOrders(List<dynamic> orders) {
    List<Widget> list = [];

    for (var order in orders) {
      list.add(OrderCard(order["placedTime"], order["price"]));
    }
    print("list length is ${list.length}");
    return list;
  }

  Widget _buildTitle(title) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 22,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
