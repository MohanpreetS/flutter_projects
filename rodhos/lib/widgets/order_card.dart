import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final String isoDate;
  final String price;

  OrderCard(this.isoDate, this.price);
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    DateTime dt = DateTime.parse(isoDate);
    final String date = DateFormat("MMMM dd, yyyy").format(dt);
    final String time = DateFormat('hh:mm a').format(dt);
    return Container(
      width: double.infinity,
      height: mq.height * 0.1,
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                date,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Grand Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              Text(
                "\$$price",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
