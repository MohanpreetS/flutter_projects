import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tesla_animated_app/constants.dart';
import 'package:tesla_animated_app/home_controller.dart';
import 'package:tesla_animated_app/models/TyrePsi.dart';

import 'components/battery_status.dart';
import 'components/door_lock.dart';
import 'components/temp_details.dart';
import 'components/tesla_bottom_nav.dart';
import 'components/tmp_btn.dart';
import './components/tyres.dart';
import 'components/tyreCard.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();

  late AnimationController _batteryController;
  late Animation<double> _animationBattery;
  late Animation<double> _animationStatus;

  late AnimationController _tempController;
  late Animation<double> _animationCarShift;
  late Animation<double> _animationTempShowInfo;
  late Animation<double> _animationCoolGlow;

  late AnimationController _tyreAnimationController;

  late Animation<double> _animateTyre1;
  late Animation<double> _animateTyre2;
  late Animation<double> _animateTyre3;
  late Animation<double> _animateTyre4;

  late List<Animation<double>> _tyreAnimations;

  void setupBatteryAnimation() {
    _batteryController = AnimationController(
      vsync: this,
      duration: defaultDuration * 2,
    );

    _animationBattery = CurvedAnimation(parent: _batteryController, curve: Interval(0, 0.5));

    _animationStatus = CurvedAnimation(parent: _batteryController, curve: Interval(0.6, 1));
  }

  void setupTempAnimation() {
    _tempController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _animationCarShift = CurvedAnimation(
      parent: _tempController,
      curve: Interval(0.2, 0.4),
    );
    _animationTempShowInfo = CurvedAnimation(
      parent: _tempController,
      curve: Interval(0.45, 0.65),
    );
    _animationCoolGlow = CurvedAnimation(
      parent: _tempController,
      curve: Interval(0.7, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1200,
      ),
    );
    _animateTyre1 = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.34, 0.5),
    );
    _animateTyre2 = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.5, 0.66),
    );
    _animateTyre3 = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.66, 0.82),
    );
    _animateTyre4 = CurvedAnimation(
      parent: _tyreAnimationController,
      curve: Interval(0.82, 1),
    );
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _animateTyre1,
      _animateTyre2,
      _animateTyre3,
      _animateTyre4,
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryController.dispose();
    _tempController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _controller,
        _batteryController,
        _tempController,
        _tyreAnimationController,
      ]),
      builder: (context, _) {
        return Scaffold(
          bottomNavigationBar: TeslaBottomNav(
            onTap: (index) {
              if (index == 1)
                _batteryController.forward();
              else if (_controller.selectedBottomTab == 1 && index != 1) _batteryController.reverse(from: 0.85);

              if (index == 2)
                _tempController.forward();
              else if (_controller.selectedBottomTab == 2 && index != 2) _tempController.reverse(from: 0.4);

              if (index == 3)
                _tyreAnimationController.forward();
              else if (_controller.selectedBottomTab == 3 && index != 3) _tyreAnimationController.reverse();

              _controller.showTyreController(index);
              _controller.tyreStatusController(index);
              _controller.onBottomNavTabChange(index);
            },
            selectedTab: _controller.selectedBottomTab,
          ),
          body: SafeArea(),
        );
      },
    );
  }
}
