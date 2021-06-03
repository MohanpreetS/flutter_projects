import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../models/order_item.dart';

class CartPanel extends StatefulWidget {
  var orderItem;

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
            Text(
              '\$' + subTotal,
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ],
        ),
      ),
      height: mQuery.size.height * 0.085,
      margin: EdgeInsets.symmetric(horizontal: 3),
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
