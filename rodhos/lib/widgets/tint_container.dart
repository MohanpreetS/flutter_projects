import 'dart:ui';

import 'package:flutter/material.dart';

class TintContainer extends StatefulWidget {
  final child;
  final opacity;
  final color;

  TintContainer({this.child, this.opacity, this.color});
  @override
  _TintContainerState createState() => _TintContainerState();
}

class _TintContainerState extends State<TintContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // boxShadow: [
          //   BoxShadow(
          //     blurRadius: 6,
          //     spreadRadius: 1,
          //     color: Colors.black.withOpacity(0.15),
          //     offset: Offset(1, 5),
          //   )
          // ],
          ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),F
            decoration: BoxDecoration(
              color: widget.color.withOpacity(widget.opacity),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
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
