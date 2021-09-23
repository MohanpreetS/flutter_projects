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
    final orderProvider =
        Provider.of<Order>(context, listen: false).fetchOrders(context);
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final orderProvider = Provider.of<Order>(context);
    final prevOrders = orderProvider.previousOrders;
    final currentOrders = orderProvider.currentOrders;
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Orders'),
        actions: [
          IconButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                await orderProvider.fetchOrders(context);

                setState(() {
                  isLoading = false;
                });
              },
              icon: Icon(Icons.refresh))
        ],
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: const CircularProgressIndicator(),
            )
          : SafeArea(
              child: (currentOrders.isNotEmpty || prevOrders.isNotEmpty)
                  ? ListView(
                      children: [
                        if (currentOrders.isNotEmpty) SizedBox(height: 15),
                        if (currentOrders.isNotEmpty)
                          _buildTitle("Current Orders"),
                        if (currentOrders.isNotEmpty)
                          ..._buildPreviousOrders(currentOrders).reversed,
                        if (prevOrders.isNotEmpty)
                          SizedBox(
                            height: 15,
                          ),
                        if (prevOrders.isNotEmpty)
                          _buildTitle("Previous Orders"),
                        if (prevOrders.isNotEmpty)
                          ..._buildPreviousOrders(prevOrders).reversed,
                      ],
                    )
                  : Center(
                      child: Text("No previous orders!"),
                    ),
            ),
    );
  }

  List<Widget> _buildPreviousOrders(List<dynamic> orders) {
    List<Widget> list = [];

    for (var order in orders) {
      list.add(OrderCard(order["placedTime"], order["price"]));
    }
    //print("list length is ${list.length}");
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
