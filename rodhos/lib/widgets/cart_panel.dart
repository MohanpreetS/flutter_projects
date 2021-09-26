import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/edit_dish_dialog.dart';
import '../providers/order.dart';
import '../providers/dishes.dart';
import '../models/order_item.dart';
import '../widgets/dish_dialog.dart';
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
    var dishess = Provider.of<Dishes>(context);

    final mQuery = MediaQuery.of(context);
    var subTotal =
        (widget.orderItem.price * widget.orderItem.quantity).toStringAsFixed(2);
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 3,
      ),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          _buildPlusMinus(order),
          IconButton(
              onPressed: () {
                print(widget.orderItem.request);
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (c) {
                    return EditDishDialog(
                      orderItem: widget.orderItem,
                    );
                  },
                );
              },
              icon: Icon(
                Icons.edit,
                color: Colors.grey.shade500,
              )),
          Container(
            width: 55,
            child: Text(
              '\$' + subTotal,
              style: TextStyle(
                fontSize: 16,
              ),
              softWrap: true,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
      height: mQuery.size.height * 0.085,
      margin: EdgeInsets.symmetric(horizontal: 4),
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

  Widget _buildPlusMinus(order) {
    return Row(
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
    );
  }

  String _makeTitle() {
    if (widget.orderItem.isMultiSize) {
      if (widget.orderItem.size == Size.small) {
        return '${widget.orderItem.title} (S)';
      } else if (widget.orderItem.size == Size.medium) {
        return '${widget.orderItem.title} (M)';
      }
      if (widget.orderItem.size == Size.large) {
        return '${widget.orderItem.title} (L)';
      }
    } else {
      return widget.orderItem.title;
    }
    return widget.orderItem.title;
  }
}
