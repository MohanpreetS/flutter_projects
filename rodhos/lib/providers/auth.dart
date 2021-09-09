import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _username;
  String? _email;
  int? _activeOrderId;

  bool get isAuth {
    return token != null;
  }

  int? get activeOrderId {
    return _activeOrderId;
  }

  String? get username {
    return _username;
  }

  String? get email {
    return _email;
  }

  String? get token {
    return _token;
  }

  Future<int?> newOrder() async {
    const addUrl = "https://rodhosapi.herokuapp.com/dishes/orders/create/";
    final createResponse = await http.post(Uri.parse(addUrl),
        body: json.encode({
          "items": [],
          "active": true,
          "placed": false,
          "price": "0.00",
          "address1": "",
          "address2": "",
          "city": "",
          "postal": "",
        }),
        headers: {
          "Authorization": "token $token",
          'Content-type': 'application/json',
        });
    var newOrder = json.decode(createResponse.body);
    _activeOrderId = newOrder["id"];
    //print("new order id is $_activeOrderId");
    return _activeOrderId;
  }

  Future<void> login(username, password) async {
    const url = "https://rodhosapi.herokuapp.com/account/login/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'username': username,
            'password': password,
          },
        ),
        headers: {
          'Content-type': 'application/json',
        },
      );
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['non_field_errors'] != null) {
        throw HttpException(responseData['non_field_errors']);
      }
      _token = responseData['token'];
      _username = username;
      //print("username set");
    } catch (err) {
      print("error catched");
      throw err;
    }
    const orderUrl = "https://rodhosapi.herokuapp.com/dishes/orders/";
    final orderResponse = await http.get(Uri.parse(orderUrl));
    final orderList = json.decode(orderResponse.body);
    //print(json.decode(orderResponse.body));
    bool orderExists = false;
    int? orderId;
    for (var order in orderList) {
      if (order['customer'] == username && order['active'] == true) {
        orderExists = true;
        orderId = order['id'];
      }
    }
    if (!orderExists) {
      const addUrl = "https://rodhosapi.herokuapp.com/dishes/orders/create/";
      final createResponse = await http.post(Uri.parse(addUrl),
          body: json.encode({
            "items": [],
            "active": true,
            "placed": false,
            "price": "0.00",
            "address1": "",
            "address2": "",
            "city": "",
            "postal": "",
          }),
          headers: {
            "Authorization": "token $token",
            'Content-type': 'application/json',
          });
      var newOrder = json.decode(createResponse.body);
      orderId = newOrder["id"];
    }
    _activeOrderId = orderId;
    notifyListeners();
  }

  Future<void> signup(username, email, password, password2) async {
    const url = "https://rodhosapi.herokuapp.com/account/register/";
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode(
          {
            'username': username,
            'email': email,
            'password': password,
            'password2': password2,
          },
        ),
        headers: {
          'Content-type': 'application/json',
        },
      );

      final responseData = json.decode(response.body);
      if (responseData['Error'] != null) {
        throw HttpException(responseData['Error']);
      }
      print("token is $responseData");
      if (responseData['username'] != null &&
          responseData['response'] == null) {
        throw HttpException('This username already exists!');
      }
      _token = responseData['token'];
      _username = username;
      _email = email;
    } catch (err) {
      print("here is the error");
      throw err;
    }
    const addUrl = "https://rodhosapi.herokuapp.com/dishes/orders/create/";
    final createResponse = await http.post(Uri.parse(addUrl),
        body: json.encode({
          "items": [],
          "active": true,
          "placed": false,
          "price": "0.00",
          "address1": "",
          "address2": "",
          "city": "",
          "postal": "",
        }),
        headers: {
          "Authorization": "token $token",
          'Content-type': 'application/json',
        });
    var newOrder = json.decode(createResponse.body);
    int orderId = newOrder["id"];
    _activeOrderId = orderId;
    notifyListeners();
  }
}
