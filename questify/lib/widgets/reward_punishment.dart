import 'package:flutter/material.dart';

class RewardPunishment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // border: Border(
        //   left: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        //   right: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        //   bottom: BorderSide(color: Theme.of(context).primaryColor, width: 2),
        // ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.grade_rounded),
              label: Text('Rewards'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.yellowAccent.shade700),
              ),
            ),
          ),
          SizedBox(
            width: 150,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.not_interested),
              label: Text('Punishments'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
