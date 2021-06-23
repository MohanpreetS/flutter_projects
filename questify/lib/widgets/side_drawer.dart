import 'package:flutter/material.dart';

import '../templates/medium_white_container.dart';
import '../screens/all_tasks_screen.dart';

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Widget drawerItem(label, ontap) {
      return GestureDetector(
        onTap: ontap,
        child: Container(
          margin: EdgeInsets.symmetric(
            horizontal: 6,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.ballot,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
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

    return Drawer(
      child: Container(
        child: ListView(
          children: [
            drawerItem(
                'All tasks',
                () => Navigator.of(context)
                    .pushReplacementNamed(AllTasksScreen.routeName)),
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
}
