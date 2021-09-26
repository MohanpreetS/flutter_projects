import 'package:flutter/material.dart';

import './dish_dialog.dart';
import '../models/dish_item.dart';
import './size_dish_dialog.dart';

class DishTile extends StatefulWidget {
  final DishItem dishItem;

  DishTile({required this.dishItem});

  @override
  _DishTileState createState() => _DishTileState();
}

class _DishTileState extends State<DishTile> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return GestureDetector(
      onTap: () {
        if (widget.dishItem.isMultiSize) {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (c) {
              return SizeDishDialog(
                dishItem: widget.dishItem,
              );
            },
          );
        } else {
          showDialog(
            context: context,
            barrierColor: Colors.transparent,
            builder: (c) {
              return DishDialog(
                dishItem: widget.dishItem,
              );
            },
          );
        }
      },
      child: Container(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: mQuery.size.width * 0.7,
                    child: Text(
                      widget.dishItem.title,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                              // bottomLeft
                              offset: Offset(-0.7, -0.7),
                              color: Colors.black),
                          Shadow(
                              // bottomRight
                              offset: Offset(0.7, -0.7),
                              color: Colors.black),
                          Shadow(
                              // topRight
                              offset: Offset(0.7, 0.7),
                              color: Colors.black),
                          Shadow(
                              // topLeft
                              offset: Offset(-0.7, 0.7),
                              color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    width: mQuery.size.width * 0.7,
                    child: Text(
                      widget.dishItem.description,
                      //softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.grey.shade100,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
              child: Text(
                '\$${widget.dishItem.price.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        height: 100,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(20),
          //color: Theme.of(context).primaryColorLight,
          gradient: LinearGradient(colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withOpacity(0.7),
          ]),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 3),
            )
          ],
        ),
      ),
    );
  }
}
