import 'package:flutter/material.dart';

class CartTotalBox extends StatelessWidget {
  final String title;
  final double amount;

  CartTotalBox(this.title, this.amount);
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
              title,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: (title == 'Grand Total')
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
          Container(
            child: Center(
              child: Text(
                amount.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 16,
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
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
          ),
        ],
      ),
    );
  }
}
