import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_home_animation/core/core.dart';
import 'package:ui_common/ui_common.dart';

import '../../../../core/shared/presentation/widgets/room_card.dart';
import '../../../smart_room/screens/room_details_screen.dart';
import '../widgets/lighted_background.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 0.8);
  final ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);

  @override
  void initState() {
    controller.addListener(pageListener);
    super.initState();
  }

  @override
  void dispose() {
    controller
      ..removeListener(pageListener)
      ..dispose();
    super.dispose();
  }

  void pageListener() {
    pageNotifier.value = controller.page ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return LightedBackgound(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const ShAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 24),
              Text("SELECT A ROOM", style: context.bodyLarge),
              const SizedBox(height: 32),
              Expanded(
                child: Stack(
                  fit: StackFit.expand,
                  children: [],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
