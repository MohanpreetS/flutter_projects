import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/main_drawer.dart';
import '../providers/orders.dart';
import '../providers/auth.dart';

class OrderScreen extends StatefulWidget {
  OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (Provider.of<Orders>(context, listen: false).previousOrders.length ==
        0) {
      await Provider.of<Auth>(context, listen: false).doFetching(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Active Orders"),
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text("Order page"),
      ),
    );
  }
}
