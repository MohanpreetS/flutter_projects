import 'package:flutter/material.dart';
import 'package:smart_home_animation/core/core.dart';

import 'package:ui_common/ui_common.dart';

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          // debugShowCheckedModeBanner: false,
          title: 'Smart Home Animated App',
          theme: SHTheme.dark,
        );
      },
    );
  }
}
