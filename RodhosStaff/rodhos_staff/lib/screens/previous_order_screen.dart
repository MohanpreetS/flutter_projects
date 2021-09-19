import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/main_drawer.dart';
import '../widgets/previous_order_card.dart';

class PreviousOrderScreen extends StatefulWidget {
  PreviousOrderScreen({Key? key}) : super(key: key);

  @override
  State<PreviousOrderScreen> createState() => _PreviousOrderScreenState();
}

class _PreviousOrderScreenState extends State<PreviousOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Previous Orders"),
      ),
      drawer: MainDrawer(),
      body: Center(
        child: PreviousOrderCard(
          order: orderProvider.previousOrders[1],
        ),
      ),
    );
  }
}
