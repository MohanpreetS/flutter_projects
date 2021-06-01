import 'package:flutter/material.dart';

import '../widgets/home_section.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Rodhos'),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(mQuery.size.height * 0.3),
            child: Container(
              height: mQuery.size.height * 0.215,
              width: mQuery.size.width * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
              ),
              margin: EdgeInsets.only(
                bottom: 50,
                left: 50,
                right: 50,
              ),
              child: Center(
                child: Text('Best dishes'),
              ),
              //TODO: Carousel Slider
            ),
          ),
        ),
        body: ListView(
          children: [
            HomeSection(
              color: Colors.white,
              nextColor: Theme.of(context).primaryColor,
            ),
            HomeSection(
              nextColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),
            HomeSection(
              color: Colors.white,
              nextColor: Theme.of(context).primaryColor,
            ),
            HomeSection(
              nextColor: Colors.white,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ));
  }
}
