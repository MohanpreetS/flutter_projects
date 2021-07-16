import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order.dart';
import '../models/dish_item.dart';

class DishDialog extends StatefulWidget {
  final DishItem dishItem;

  DishDialog({
    required this.dishItem,
  });
  @override
  _DishDialogState createState() => _DishDialogState();
}

class _DishDialogState extends State<DishDialog> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    var order = Provider.of<Order>(context);
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        height: mQuery.size.height * 0.4,
        width: mQuery.size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTitle(),
            _buildDescription(),
            _buildSpecialRequest(),
            _buildPlusMinus(),
            _buildAddButton(order),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      child: Text(
        widget.dishItem.title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 3,
        ),
      ),
      margin: EdgeInsets.only(
        top: 20,
      ),
    );
  }

  Widget _buildDescription() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3),
      margin: EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        widget.dishItem.description,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16),
      ),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: Colors.black,
        //   width: 1,
        // ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget _buildSpecialRequest() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(
        //vertical: 2,
        horizontal: 5,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(20)),
      child: Form(
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Special Request',
            border: InputBorder.none,
          ),
          maxLines: 3,
          keyboardType: TextInputType.multiline,
          onFieldSubmitted: (_) {},
        ),
      ),
    );
  }

  Widget _buildPlusMinus() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              //order.decreaseCount(widget.orderItem.orderItemId);
              setState(() {
                if (qty > 1) {
                  qty--;
                }
              });
            },
            icon: Icon(Icons.remove_circle_outline_rounded),
            color: Colors.red,
          ),
          Container(
            child: Center(
              child: Text(
                qty.toString(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              //order.increaseCount(widget.orderItem.orderItemId);
              setState(() {
                qty++;
              });
            },
            icon: Icon(
              Icons.add_circle_outline_rounded,
              color: Colors.green,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAddButton(order) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      child: ElevatedButton(
        onPressed: () {
          order.addToOrder(widget.dishItem, qty);
          Navigator.of(context).pop();
        },
        child: Text(
          'Add to cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
