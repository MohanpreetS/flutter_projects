import 'package:flutter/material.dart';

class DishTile extends StatelessWidget {
  final title;
  final description;
  final price;

  DishTile({
    required this.title,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Text(
                    title,
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
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.53,
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  description,
                  softWrap: true,
                  style: TextStyle(color: Colors.grey.shade100),
                ),
              ),
            ],
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Text(
              '\$$price',
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
      height: MediaQuery.of(context).size.height * 0.12,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.all(8),
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
          ]),
    );
  }
}
