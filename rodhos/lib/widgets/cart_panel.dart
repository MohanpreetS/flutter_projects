import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../models/order_item.dart';
import '../models/dish_item.dart';

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
          Container(
            width: mQuery.size.width * 0.4,
            child: Text(
              _makeTitle(),
              style: TextStyle(
                fontSize: 18,
              ),
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

  String _makeTitle() {
    if (widget.orderItem.dish.isMultiSize) {
      if (widget.orderItem.dish.size == Size.small) {
        return '${widget.orderItem.dish.title} (S)';
      } else if (widget.orderItem.dish.size == Size.medium) {
        return '${widget.orderItem.dish.title} (M)';
      }
      if (widget.orderItem.dish.size == Size.large) {
        return '${widget.orderItem.dish.title} (L)';
      }
    } else {
      return widget.orderItem.dish.title;
    }
    return widget.orderItem.dish.title;
  }
}
