import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

Future<void> makePayment() async {
  final url = Uri.parse(
      "https://us-central1-rodhospayment123.cloudfunctions.net/stripePayment");

  final response = await http.get(
    url,
    headers: {
      'Content-type': 'application/json',
    },
  );

  var paymentIntentData = json.decode(response.body);

  await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['paymentIntent'],
          applePay: true,
          googlePay: true,
          style: ThemeMode.light,
          merchantCountryCode: 'CA',
          merchantDisplayName: 'Rodhos Pizza'));
}
