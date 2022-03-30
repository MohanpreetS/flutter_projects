import 'package:flutter/material.dart';
import 'package:tesla_animated_app/models/TyrePsi.dart';
import '../../constants.dart';

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
