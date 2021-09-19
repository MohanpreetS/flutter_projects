import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../screens/order_detail_screen.dart';

class PreviousOrderCard extends StatefulWidget {
  dynamic order;

  PreviousOrderCard({Key? key, this.order}) : super(key: key);
  @override
  _PreviousOrderCardState createState() => _PreviousOrderCardState();
}

class _PreviousOrderCardState extends State<PreviousOrderCard> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final size = mq.size;
    DateTime dt = DateTime.parse(widget.order["placedTime"]);
    final String date = DateFormat("MMMM dd, yyyy").format(dt);
    final String time = DateFormat('hh:mm a').format(dt);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderDetailScreen(
              order: widget.order,
            ),
          ),
        );
      },
      child: Container(
        height: 100,
        width: size.width * 0.95,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 3),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.6),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLeftColumn(date, time),
            _buildRightColumn(),
          ],
        ),
      ),
    );
  }

  Widget _buildLeftColumn(date, time) {
    return Column(
      children: [
        SizeText(label: widget.order["customer"], size: 18, bold: true),
        SizeText(label: "order id: ${widget.order["id"]}", size: 15),
        const Spacer(),
        SizeText(label: date, size: 16),
        SizeText(label: time, size: 16),
      ],
    );
  }

  Widget _buildRightColumn() {
    return Column(
      children: [
        SizeText(label: widget.order["address1"], size: 15),
        if (widget.order["address2"].length != 0)
          SizeText(label: widget.order["address2"], size: 15),
        SizeText(
            label: "${widget.order["city"]} , ${widget.order["postal"]}",
            size: 15),
        const Spacer(),
        SizeText(label: "\$${widget.order["price"]}", size: 18, bold: true),
      ],
    );
  }
}

class SizeText extends StatelessWidget {
  final String label;
  final double size;
  final bool bold;
  const SizeText({
    Key? key,
    required this.label,
    required this.size,
    this.bold = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: size,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
