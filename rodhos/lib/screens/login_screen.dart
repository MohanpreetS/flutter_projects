import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import './register_screen.dart';
import './home_screen.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  var errorMsg;
  final TextEditingController mobileController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: <Widget>[
                  TextFormField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: "username",
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
                  FlatButton(
                    onPressed: () {
                      print("Login pressed");
                      setState(() {
                        _isLoading = true;
                      });
                      signIn(mobileController.text, passwordController.text);
                    },
                    child:
                        Text("Sign In", style: TextStyle(color: Colors.black)),
                  ),
                  errorMsg == null
                      ? Container()
                      : Text(
                          "$errorMsg",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Not have an account? Create one,,,',
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 15,
                    ),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  RegisterPage()),
                          (Route<dynamic> route) => false);
                    },
                    elevation: 0.0,
                    color: Colors.purple,
                    child: Text("Register",
                        style: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
      ),
    );
  }

  signIn(String username, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {'username': username, 'password': pass};
    var jsonResponse;
    var url = "https://rodhosapi.herokuapp.com/account/login/";
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
