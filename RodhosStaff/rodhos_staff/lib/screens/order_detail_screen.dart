import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../providers/dishes.dart';
import '../models/dish_item.dart';

class OrderDetailScreen extends StatelessWidget {
  final dynamic order;
  const OrderDetailScreen({Key? key, this.order}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final dishProvider = Provider.of<Dishes>(context);
    final dishes = dishProvider.dishes;

    return Scaffold(
      appBar: AppBar(
        title: Text("${order["customer"]} : ${order["id"]}"),
      ),
      body: SizedBox(
        height: mq.size.height * 0.95,
        width: mq.size.width,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints.tightFor(
              height: mq.size.height,
            ),
            child: Container(
              height: double.infinity,
              padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ..._buildNameIdTotal(mq.size.width * 0.5),
                    ..._buildDateTime(mq.size.width * 0.5),
                    ..._buildAddress(mq.size.width * 0.5),
                    ..._buildOrderItems(dishes),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget heading(label) {
    return Text(
      label,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }

  Widget dishText(label, middle) {
    return Text(
      label,
      style: const TextStyle(fontSize: 18),
      textAlign: middle ? TextAlign.center : TextAlign.left,
    );
  }

  Widget orderLine(name, size, qty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: dishText(name, false), flex: 6, fit: FlexFit.tight),
        Flexible(child: dishText(size, true), flex: 2, fit: FlexFit.tight),
        Flexible(child: dishText(qty, true), flex: 2, fit: FlexFit.tight),
      ],
    );
  }

  List<Widget> _buildOrderItems(dishes) {
    var dishList = [];
    var items = order["items"];
    for (var item in items) {
      final myDishItem = dishes.firstWhere((d) => d.id == item["dish"]);
      dishList.add(orderLine(
          myDishItem.title, item["size"], item["quantity"].toString()));
      dishList.add(const Divider(thickness: 0.75, indent: 30, endIndent: 30));
    }

    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: heading("Dish"), flex: 6, fit: FlexFit.tight),
          Flexible(child: heading("Size"), flex: 2, fit: FlexFit.tight),
          Flexible(child: heading("Quantity"), flex: 2, fit: FlexFit.tight),
        ],
      ),
      SizedBox(height: 5),
      ...dishList,
    ];
  }

  Widget _buildTitleValue(title, value, width) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "$title:",
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            width: width,
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 20,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNameIdTotal(width) {
    return [
      _buildTitleValue("Username", order["customer"], width),
      _buildTitleValue("Order Id", order["id"].toString(), width),
      _buildTitleValue("Total", "\$${order["price"]}", width),
      const Divider(thickness: 1.5),
    ];
  }

  List<Widget> _buildDateTime(width) {
    DateTime dt = DateTime.parse(order["placedTime"]);
    final String date = DateFormat("MMMM dd, yyyy").format(dt);
    final String time = DateFormat('hh:mm a').format(dt);
    return [
      _buildTitleValue("Date", date, width),
      _buildTitleValue("Time", time, width),
      const Divider(thickness: 1.5),
    ];
  }

  List<Widget> _buildAddress(width) {
    return [
      _buildTitleValue("Address Line 1", order["address1"], width),
      _buildTitleValue("Address Line 2", order["address2"], width),
      _buildTitleValue("City", order["city"], width),
      _buildTitleValue("Postal Code", order["postal"], width),
      const Divider(thickness: 1.5),
    ];
  }
}
