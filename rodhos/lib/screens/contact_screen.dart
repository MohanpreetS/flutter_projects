import 'package:flutter/material.dart';

import './cart_screen.dart';
import '../widgets/main_drawer.dart';

class ContactScreen extends StatelessWidget {
  static const routeName = '/ContactScreen';
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      title: Text('Contact Us'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () async {
            Navigator.of(context).pushReplacementNamed(CartScreen.routeName);
          },
          icon: Icon(
            Icons.shopping_cart,
            size: 23,
          ),
        ),
      ],
    );
    return Scaffold(
      appBar: appbar,
      drawer: MainDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              buildPhone(context),
              ...buildSpacing(),
              buildEmail(context),
              ...buildSpacing(),
              buildAddress(context),
              ...buildSpacing(),
              buildOpeningHours(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget hours(day, hours, context) {
    return Container(
      margin: EdgeInsets.only(top: 5),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: EdgeInsets.only(left: 50),
            child: Text(
              day,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 40),
            child: Text(
              hours,
              style: TextStyle(
                fontSize: 18,
                //fontWeight: FontWeight.bold,
                //color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildOpeningHours(context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "Opening Hours",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        hours("Monday", "4 - 11pm", context),
        ...buildTinySpacing(),
        hours("Tuesday", "4 - 11pm", context),
        ...buildTinySpacing(),
        hours("Wednesday", "4 - 11pm", context),
        ...buildTinySpacing(),
        hours("Thursday", "4 - 11pm", context),
        ...buildTinySpacing(),
        hours("Friday", "4 - 11:30pm", context),
        ...buildTinySpacing(),
        hours("Saturday", "4 - 11:30pm", context),
        ...buildTinySpacing(),
        hours("Sunday", "4 - 10pm", context),
      ],
    );
  }

  List<Widget> buildTinySpacing() {
    return [
      SizedBox(height: 2),
      Divider(
        thickness: 1,
        indent: 70,
        endIndent: 70,
      ),
      SizedBox(height: 2),
    ];
  }

  List<Widget> buildSpacing() {
    return [
      SizedBox(height: 5),
      Divider(
        thickness: 1,
        indent: 20,
        endIndent: 20,
      ),
      SizedBox(height: 5),
    ];
  }

  Widget buildPhone(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "Phone Number",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SelectableText(
            "+1 250-624-9797",
            style: TextStyle(
              fontSize: 20,
              //color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEmail(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "Email",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SelectableText(
            "rodhospizza@gmail.com",
            style: TextStyle(
              fontSize: 20,
              //color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAddress(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(left: 10),
          child: Text(
            "Address",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(right: 10),
          child: SelectableText(
            "       716 2 Ave W, \n     Prince Rupert, \n BC V8J 1H3, Canada",
            style: TextStyle(
              fontSize: 20,
              //color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
