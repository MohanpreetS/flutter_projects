import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import './home_screen.dart';
import '../providers/auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  final TextEditingController password2Controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  TextFormField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: "Username",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: "Email",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  TextFormField(
                    controller: password2Controller,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                    ),
                  ),
                  SizedBox(height: 30.0),
                  RaisedButton(
                    onPressed: () {
                      // setState(() {
                      //   _isLoading = true;
                      // });
                      Provider.of<Auth>(context, listen: false).signup(
                          usernameController.text,
                          emailController.text,
                          passwordController.text,
                          password2Controller.text);
                      // register(usernameController.text, emailController.text,
                      //     passwordController.text, password2Controller.text);
                    },
                    color: Colors.purple,
                    child: Text("Register Yourself",
                        style: TextStyle(color: Colors.white70)),
                  ),
                  errorMsg == null
                      ? Container()
                      : Text(
                          "$errorMsg",
                        ),
                ],
              ),
      ),
    );
  }

  register(String username, email, pass, pass2) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'email': email,
      'password': pass,
      'password2': pass2
    };
    var jsonResponse;
    var url = "https://rodhosapi.herokuapp.com/account/register/";
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("token", jsonResponse['token']);
        print('the token is ${jsonResponse['token']}');
        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      errorMsg = response.body;
      print("The error message is: ${response.body}");
    }
  }
}
