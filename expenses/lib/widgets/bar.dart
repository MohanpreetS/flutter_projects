import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double pct;
  ChartBar(this.label, this.spending, this.pct);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('\$${spending.toStringAsFixed(0)}'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: pct,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            child: FittedBox(child: Text(label)),
            height: constraints.maxHeight * 0.15,
          ),
        ],
      );
    });
  }
}
