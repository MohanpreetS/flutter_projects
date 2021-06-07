import 'package:flutter/material.dart';

class DishDialog extends StatefulWidget {
  final title;
  final description;
  final price;

  DishDialog({
    required this.title,
    required this.description,
    required this.price,
  });
  @override
  _DishDialogState createState() => _DishDialogState();
}

class _DishDialogState extends State<DishDialog> {
  int qty = 1;
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Dialog(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 5,
                horizontal: 10,
              ),
              child: Text(
                widget.title,
                style: TextStyle(
                  //color: Colors.white,
                  fontSize: 20,
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                //color: Theme.of(context).primaryColor,
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 3,
                ),
              ),
              margin: EdgeInsets.only(
                top: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 3),
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    //order.decreaseCount(widget.orderItem.orderItemId);
                    setState(() {
                      qty--;
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
            Container(
              margin: EdgeInsets.only(
                bottom: 20,
              ),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Add to cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        height: mQuery.size.height * 0.4,
        width: mQuery.size.width * 0.8,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
        ),
      ),
    );
  }
}
