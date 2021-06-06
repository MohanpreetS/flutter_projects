import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../models/order_item.dart';

class CartPanel extends StatefulWidget {
  final orderItem;

  CartPanel(this.orderItem);
  @override
  _CartPanelState createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  @override
  Widget build(BuildContext context) {
    var order = Provider.of<Order>(context);
    final mQuery = MediaQuery.of(context);
    var subTotal = (widget.orderItem.dish.price * widget.orderItem.quantity)
        .toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 4,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.orderItem.dish.title,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  order.decreaseCount(widget.orderItem.orderItemId);
                },
                icon: Icon(Icons.remove_circle_outline_rounded),
                color: Colors.red,
              ),
              Container(
                child: Center(
                  child: Text(
                    widget.orderItem.quantity.toString(),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  order.increaseCount(widget.orderItem.orderItemId);
                },
                icon: Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.green,
                ),
              )
            ],
          ),
          Container(
            width: mQuery.size.width * 0.175,
            child: Text(
              '\$' + subTotal,
              style: TextStyle(
                fontSize: 17,
              ),
              softWrap: true,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
      height: mQuery.size.height * 0.085,
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 3,
          ),
        ),
      ),
    );
  }
}
