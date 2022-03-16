import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_animation/constants.dart';
import 'package:flutter_auth_animation/widgets/login_form.dart';
import 'package:flutter_auth_animation/widgets/sign_up_form.dart';
import 'package:flutter_auth_animation/widgets/social_buttons.dart';
import 'package:flutter_svg/svg.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController = AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate = Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });

    _isShowSignUp ? _animationController.forward() : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          return Stack(
            children: [
              //Login
              AnimatedPositioned(
                duration: defaultDuration,
                width: _size.width * 0.88,
                height: _size.height,
                left: _isShowSignUp ? -_size.width * 0.76 : 0,
                child: Container(
                  color: login_bg,
                  child: LoginForm(),
                ),
              ),
              //Sign up
              AnimatedPositioned(
                duration: defaultDuration,
                height: _size.height,
                width: _size.width * 0.88,
                left: _isShowSignUp ? _size.width * 0.12 : _size.width * 0.88,
                child: Container(
                  color: signup_bg,
                  child: SignUpForm(),
                ),
              ),
              //Logo
              AnimatedPositioned(
                duration: defaultDuration,
                top: _size.height * 0.1,
                left: 0,
                right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.white60,
                  child: AnimatedSwitcher(
                    duration: defaultDuration,
                    child: SvgPicture.asset(
                      "assets/animation_logo.svg",
                      color: _isShowSignUp ? signup_bg : login_bg,
                    ),
                  ),
                ),
              ),
              //Social Buttons
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _size.height * 0.1,
                width: _size.width,
                right: _isShowSignUp ? -_size.width * 0.06 : _size.width * 0.06,
                child: SocialButtons(),
              ),
              //Login text
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: _isShowSignUp ? _size.height / 2 - 80 : _size.height * 0.3,
                left: _isShowSignUp ? 0 : _size.width * 0.44 - 80,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _isShowSignUp ? 20 : 32,
                    fontWeight: FontWeight.bold,
                    color: _isShowSignUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: -_animationTextRotate.value * pi / 180,
                    alignment: Alignment.topLeft,
                    child: InkWell(
                      onTap: () {
                        if (_isShowSignUp) {
                          updateView();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        width: 160,
                        child: Text(
                          "LOGIN",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              //Sign up
              AnimatedPositioned(
                duration: defaultDuration,
                bottom: !_isShowSignUp ? _size.height / 2 - 80 : _size.height * 0.3,
                right: _isShowSignUp ? _size.width * 0.44 - 80 : 0,
                child: DefaultTextStyle(
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: !_isShowSignUp ? 20 : 32,
                    fontWeight: FontWeight.bold,
                    color: !_isShowSignUp ? Colors.white : Colors.white70,
                  ),
                  child: Transform.rotate(
                    angle: (90 - _animationTextRotate.value) * pi / 180,
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        if (!_isShowSignUp) {
                          updateView();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: defpaultPadding * 0.75),
                        width: 160,
                        child: Text(
                          "SIGN UP",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
