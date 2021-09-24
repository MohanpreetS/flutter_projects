import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'screens/tabs_screen.dart';
import './screens/account_screen.dart';
import './screens/cart_screen.dart';
import './screens/home_screen.dart';
import './screens/contact_screen.dart';
import './screens/menu_screen.dart';
import './screens/orders_screen.dart';
import './screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import './providers/dishes.dart';
import './providers/order.dart';
import './providers/auth.dart';
import './providers/user_info.dart';
import './models/api_data.dart';

void main() {
  Stripe.publishableKey =
      "pk_test_51JcHfYAWPEBS0NQduAKnoQpyrKpKOGe8fJDJcAB79goTcCw5r1Ja0RleTO3OA3WVWEuutfdEo46FYJtF61FU9Pwp00rh7DLIun";
  Stripe.merchantIdentifier = 'Rodhos';
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider(
          create: (c) => Dishes(),
        ),
        ChangeNotifierProvider(
          create: (c) => Order(0),
        ),
        ChangeNotifierProvider(
          create: (c) => UserInfo(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Rodhos',
          theme: ThemeData(
            primarySwatch: customLavendar,
            accentColor: Colors.greenAccent.shade200,
          ),

          //home: TabsScreen(2),
          builder: (context, widget) {
            return MediaQuery(
              //Setting font does not change with system font size
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          routes: {
            '/': (c) => auth.isAuth
                ? TabsScreen(0)
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapshot) =>
                        authResultSnapshot.connectionState ==
                                ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            CartScreen.routeName: (c) => TabsScreen(1),
            MenuScreen.routeName: (c) => TabsScreen(0),
            AccountScreen.routeName: (c) => AccountScreen(),
            //HomeScreen.routeName: (c) => TabsScreen(0),
            OrdersScreen.routeName: (c) => TabsScreen(2),
            ContactScreen.routeName: (c) => ContactScreen(),
          },
        ),
      ),
    );
  }
}

Map<int, Color> clr = {
  50: const Color.fromRGBO(153, 153, 255, 0.1),
  100: const Color.fromRGBO(153, 153, 255, 0.2),
  200: const Color.fromRGBO(153, 153, 255, 0.3),
  300: const Color.fromRGBO(153, 153, 255, 0.4),
  400: const Color.fromRGBO(153, 153, 255, 0.5),
  500: const Color.fromRGBO(153, 153, 255, 0.6),
  600: const Color.fromRGBO(153, 153, 255, 0.7),
  700: const Color.fromRGBO(153, 153, 255, 0.8),
  800: const Color.fromRGBO(153, 153, 255, 0.9),
  900: const Color.fromRGBO(153, 153, 255, 1),
};

MaterialColor customLavendar = MaterialColor(0xFF9999FF, clr);

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0xffe55f48, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xffce5641), //10%
      100: const Color(0xffb74c3a), //20%
      200: const Color(0xffa04332), //30%
      300: const Color(0xff89392b), //40%
      400: const Color(0xff733024), //50%
      500: const Color(0xff5c261d), //60%
      600: const Color(0xff451c16), //70%
      700: const Color(0xff2e130e), //80%
      800: const Color(0xff170907), //90%
      900: const Color(0xff000000), //100%
    },
  );
}
