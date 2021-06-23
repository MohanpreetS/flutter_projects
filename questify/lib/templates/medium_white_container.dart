import 'dart:ui';

import 'package:flutter/material.dart';

class MediumWhiteContainer extends StatefulWidget {
  var child;
  var opacity;

  MediumWhiteContainer({this.child, this.opacity});
  @override
  _MediumWhiteContainerState createState() => _MediumWhiteContainerState();
}

class _MediumWhiteContainerState extends State<MediumWhiteContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 1,
            color: Colors.black.withOpacity(0.15),
            offset: Offset(1, 5),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(widget.opacity),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(0.4),
              ),
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
