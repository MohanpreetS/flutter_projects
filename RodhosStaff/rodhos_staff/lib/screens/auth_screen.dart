import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/http_exception.dart';

class AuthScreen extends StatefulWidget {
  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<Auth>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rodhos Staff"),
      ),
      body: Center(
        child: Container(
          width: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextInput(
                textString: "Staff Username",
                textController: usernameController,
                obscureText: false,
              ),
              TextInput(
                textString: "Password",
                textController: passwordController,
                obscureText: true,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      if (usernameController.text == "" ||
                          passwordController.text == "") {
                        throw HttpException(
                            "Username or password cannot be blank");
                      }
                      await authProvider.login(usernameController.text,
                          passwordController.text, context);
                    } on HttpException catch (err) {
                      var errorMessage = err.msg;
                      _showErrorDialog(errorMessage);
                      usernameController.text = '';
                      passwordController.text = '';
                    } catch (err) {
                      var errorMessage =
                          'Could not authenticate, please verify your credentials';
                      _showErrorDialog(errorMessage);
                      usernameController.text = '';
                      passwordController.text = '';
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: const Text("Login"),
                ),
              ),
              if (isLoading) CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  void _showErrorDialog(String msg) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: const Text('An error occurred!'),
              content: Text(msg),
            ));
  }
}

class TextInput extends StatelessWidget {
  final String textString;
  final TextEditingController textController;
  final bool obscureText;
  const TextInput(
      {Key? key,
      required this.textString,
      required this.textController,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        style: const TextStyle(color: Color(0xFF000000)),
        cursorColor: const Color(0xFF9b9b9b),
        controller: textController,
        keyboardType: TextInputType.text,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: textString,
          hintStyle: const TextStyle(
              color: Color(0xFF9b9b9b),
              fontSize: 15,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}
