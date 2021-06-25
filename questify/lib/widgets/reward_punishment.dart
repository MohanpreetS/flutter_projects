import 'dart:ui';

import 'package:flutter/material.dart';

import './add_button.dart';

class RewardPunishment extends StatelessWidget {
  final addNewSubtask;
  final showRewards;

  RewardPunishment(this.addNewSubtask, this.showRewards);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //margin: EdgeInsets.only(bottom: 5),
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
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.4,
            height: 50,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.only(
            //     topLeft: Radius.circular(20),
            //     bottomLeft: Radius.circular(20),
            //   ),
            // ),
            child: ElevatedButton.icon(
              onPressed: showRewards,
              icon: Icon(Icons.grade_rounded),
              label: Text('Rewards'),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.yellowAccent.shade700),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AddButton(addNewSubtask),
          Container(
            width: size.width * 0.4,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.not_interested),
              label: Text(
                'Punishment',
                softWrap: true,
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                      bottomLeft: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
