import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _username;
  String? _email;
  late int _activeOrderId;

  bool get isAuth {
    return token != null;
  }

  int get activeOrderId {
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
    final orderUrl = "https://rodhosapi.herokuapp.com/dishes/orders/$username";
    final orderResponse = await http.get(Uri.parse(orderUrl));
    final orderList = json.decode(orderResponse.body);

    bool orderExists = false;
    int orderId;
    for (var order in orderList) {
      if (order['active'] == true) {
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
      _activeOrderId = orderId;
    }

    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'username': _username,
      'email': _email,
      'activeOrderId': _activeOrderId,
    });
    prefs.setString('userData', userData);
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedData['token'];
    _email = extractedData['email'];
    _username = extractedData['username'];
    _activeOrderId = extractedData['activeOrderId'];
    notifyListeners();
    return true;
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
    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'username': _username,
      'email': _email,
      'activeOrderId': _activeOrderId,
    });
    prefs.setString('userData', userData);
  }

  void logout() async {
    _token = null;
    _username = null;
    _email = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
