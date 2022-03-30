import 'package:flutter/material.dart';
import 'package:tesla_animated_app/models/TyrePsi.dart';
import '../../constants.dart';

Widget lowPressureText(BuildContext context) {
  return Column(
    children: [
      Text(
        "LOW",
        style: Theme.of(context).textTheme.headline3!.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
      ),
      Text(
        "PRESSURE",
        style: TextStyle(fontSize: 20),
      ),
    ],
  );
}

Text psiText(BuildContext context, {required String psi}) {
  return Text.rich(
    TextSpan(
      text: psi,
      style: Theme.of(context).textTheme.headline4!.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
      children: [
        TextSpan(
          text: "psi",
          style: TextStyle(fontSize: 24),
        ),
      ],
    ),
  );
}
