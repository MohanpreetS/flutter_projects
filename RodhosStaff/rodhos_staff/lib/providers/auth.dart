import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './orders.dart';
import './dishes.dart';
import './http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  String? _username;

  bool get isAuth {
    return token != null;
  }

  String? get username {
    return _username;
  }

  String? get token {
    return _token;
  }

  Future<void> login(username, password, context) async {
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

      // if (responseData['non_field_errors'] != null) {
      //   throw HttpException(responseData['non_field_errors']);
      // }
      if (responseData['non_field_errors'] != null) {
        throw HttpException(responseData['non_field_errors']);
      }
      _token = responseData['token'];
      _username = username;
      //print("username set");
    } catch (err) {
      rethrow;
    }

    if (isAuth) {
      doFetching(context);

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'username': _username,
      });
      prefs.setString('userData', userData);
    }
    notifyListeners();
  }

  Future<void> doFetching(context) async {
    final orderProvider = Provider.of<Orders>(context, listen: false);
    orderProvider.fetchOrders(context);
    final dishProvider = Provider.of<Dishes>(context, listen: false);
    dishProvider.fetchData();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    _token = extractedData['token'];
    _username = extractedData['username'];
    notifyListeners();
    return false;
  }

  void logout() async {
    _token = null;
    _username = null;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
