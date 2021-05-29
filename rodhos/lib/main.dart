import 'package:flutter/material.dart';

import 'screens/tabs_screen.dart';
import './screens/account_screen.dart';
import './screens/cart_screen.dart';
import './screens/home_screen.dart';
import './screens/menu_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: customLavendar,
        accentColor: Colors.cyan.shade300,
      ),
      //home: TabsScreen(),
      routes: {
        '/': (c) => TabsScreen(0),
        CartScreen.routeName: (c) => CartScreen(),
        MenuScreen.routeName: (c) => MenuScreen(),
        AccountScreen.routeName: (c) => AccountScreen(),
        HomeScreen.routeName: (c) => HomeScreen(),
      },
    );
  }
}

Map<int, Color> clr = {
  50: Color.fromRGBO(153, 153, 255, 0.1),
  100: Color.fromRGBO(153, 153, 255, 0.2),
  200: Color.fromRGBO(153, 153, 255, 0.3),
  300: Color.fromRGBO(153, 153, 255, 0.4),
  400: Color.fromRGBO(153, 153, 255, 0.5),
  500: Color.fromRGBO(153, 153, 255, 0.6),
  600: Color.fromRGBO(153, 153, 255, 0.7),
  700: Color.fromRGBO(153, 153, 255, 0.8),
  800: Color.fromRGBO(153, 153, 255, 0.9),
  900: Color.fromRGBO(153, 153, 255, 1),
};

MaterialColor customLavendar = MaterialColor(0xFF9999FF, clr);
