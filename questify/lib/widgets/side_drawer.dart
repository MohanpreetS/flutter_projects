import 'package:flutter/material.dart';

import '../templates/medium_white_container.dart';
import '../screens/all_tasks_screen.dart';
import '../screens/motivators_screen.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Drawer(
      child: Container(
        child: ListView(
          children: [
            drawerItem(
              'All tasks',
              () => Navigator.of(context)
                  .pushReplacementNamed(AllTasksScreen.routeName),
              Icons.ballot,
              size,
            ),
            drawerItem(
              'Motivators',
              () => Navigator.of(context)
                  .pushReplacementNamed(MotivatorsScreen.routeName),
              Icons.fireplace_rounded,
              size,
            ),
          ],
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purpleAccent.shade200,
              Colors.blueAccent.shade400,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  Widget drawerItem(label, ontap, icon, size) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 6,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 6,
              spreadRadius: 1,
              color: Colors.black.withOpacity(0.15),
              offset: Offset(1, 3),
            ),
          ],
        ),
        child: MediumWhiteContainer(
          child: Container(
            height: size.height * 0.07,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    icon,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
          opacity: 0.5,
        ),
      ),
    );
  }
}
