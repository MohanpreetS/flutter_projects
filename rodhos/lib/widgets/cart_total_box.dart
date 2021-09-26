import 'package:flutter/material.dart';

class CartTotalBox extends StatefulWidget {
  final String title;
  final double amount;

  CartTotalBox(this.title, this.amount);

  @override
  _CartTotalBoxState createState() => _CartTotalBoxState();
}

class _CartTotalBoxState extends State<CartTotalBox> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Center(
                child: Text(
              widget.title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: (widget.title == 'Grand Total')
                      ? FontWeight.bold
                      : FontWeight.normal),
            )),
            margin: EdgeInsets.only(
              left: 10,
            ),
            width: mQuery.size.width * 0.5,
            height: mQuery.size.height * 0.042,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Row(
            children: [
              Text("\$", style: TextStyle(color: Colors.white, fontSize: 20)),
              Container(
                child: Center(
                  child: Text(
                    widget.amount.toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: (widget.title == 'Grand Total')
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
                width: mQuery.size.width * 0.2,
                height: mQuery.size.height * 0.042,
                margin: EdgeInsets.only(
                  right: 10,
                  top: 1,
                  bottom: 2,
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
