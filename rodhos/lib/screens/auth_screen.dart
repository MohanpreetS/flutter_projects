import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/text_widget.dart';
import '../providers/auth.dart';
import '../providers/order.dart';
import '../providers/dishes.dart';
import '../models/http_exception.dart';

enum AuthMode { Signup, Login }

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  var authMode = AuthMode.Login;
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    final double height = mQ.size.height;
    final statusBarHeight = mQ.padding.top;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color(0xFFffffff),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: SingleChildScrollView(
            child: Container(
              height: height - statusBarHeight,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: height * 0.05),
                  TextWidget(
                      text: "Welcome to", fontSize: 26, isUnderLine: false),
                  TextWidget(
                      text: "Rodhos Pizza", fontSize: 26, isUnderLine: false),
                  SizedBox(height: height * 0.05),
                  TextInput(
                      textString: "Username",
                      textController: usernameController,
                      obscureText: false),
                  SizedBox(height: height * 0.05),
                  if (authMode == AuthMode.Signup)
                    TextInput(
                        textString: "Email",
                        textController: emailController,
                        obscureText: false),
                  if (authMode == AuthMode.Signup)
                    SizedBox(
                      height: height * .05,
                    ),
                  TextInput(
                      textString: "Password",
                      textController: passwordController,
                      obscureText: true),
                  SizedBox(
                    height: height * .05,
                  ),
                  if (authMode == AuthMode.Signup)
                    TextInput(
                        textString: "Confirm Password",
                        textController: password2Controller,
                        obscureText: true),
                  if (authMode == AuthMode.Signup)
                    SizedBox(
                      height: height * .05,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (authMode == AuthMode.Signup)
                        TextWidget(
                            text: "Sign up", fontSize: 22, isUnderLine: false),
                      if (authMode == AuthMode.Login)
                        TextWidget(
                            text: "Login", fontSize: 22, isUnderLine: false),
                      if (isLoading) CircularProgressIndicator(),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            isLoading = true;
                          });
                          var auth = Provider.of<Auth>(context, listen: false);
                          try {
                            if (authMode == AuthMode.Signup) {
                              await auth.signup(
                                  usernameController.text,
                                  emailController.text,
                                  passwordController.text,
                                  password2Controller.text);
                            } else {
                              await auth.login(usernameController.text,
                                  passwordController.text);
                            }
                          } on HttpException catch (err) {
                            var errorMessage = err.msg;
                            _showErrorDialog(errorMessage);
                          } catch (err) {
                            if (authMode == AuthMode.Login) {
                              var errorMessage = err.toString();
                              //  'Could not authenticate, please try again later';
                              _showErrorDialog(errorMessage);
                            } else {
                              var errorMessage =
                                  'Could not register, please try again later';
                              _showErrorDialog(errorMessage);
                            }
                          }

                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                            //color: Color(0xFF363f93),
                          ),
                          child: Icon(Icons.arrow_forward,
                              color: Colors.white, size: 30),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  _buildBottom(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottom() {
    return Container(
      margin: EdgeInsets.only(bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                switchMode();
              });
            },
            child: TextWidget(
                text: switchModeText(), fontSize: 18, isUnderLine: true),
          ),
          if (authMode == AuthMode.Login)
            GestureDetector(
              onTap: _launchURL,
              child: TextWidget(
                  text: "Forgot Password", fontSize: 18, isUnderLine: true),
            )
        ],
      ),
    );
  }

  _launchURL() {
    const url = 'https://rodhosapi.herokuapp.com/account/password_reset/';
    launch(url);
  }

  void switchMode() {
    if (authMode == AuthMode.Signup) {
      authMode = AuthMode.Login;
    } else {
      authMode = AuthMode.Signup;
    }
    password2Controller.text = '';
    passwordController.text = '';
  }

  String switchModeText() {
    if (authMode == AuthMode.Signup) {
      return "Login";
    }
    return "Sign up";
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An error occurred!'),
              content: Text(msg),
            ));
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final bool obscureText;
  TextInput(
      {Key? key,
      required this.textString,
      required this.textController,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Color(0xFF000000)),
      cursorColor: Color(0xFF9b9b9b),
      controller: textController,
      keyboardType: TextInputType.text,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: this.textString,
        hintStyle: TextStyle(
            color: Color(0xFF9b9b9b),
            fontSize: 15,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
