import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rodhos_staff/providers/orders.dart';

import './providers/auth.dart';
import './providers/dishes.dart';
import 'screens/order_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (c) => Orders(),
        ),
        ChangeNotifierProvider(
          create: (c) => Dishes(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Rodhos Staff',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.greenAccent.shade200,
          ),
          builder: (context, widget) {
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          //home: auth.isAuth ? MyHomePage() : AuthScreen(),
          routes: {
            '/': (c) => auth.isAuth
                ? OrderScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
          },
        ),
      ),
    );
  }
}
