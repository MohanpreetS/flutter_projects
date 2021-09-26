import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';

import '../providers/order.dart';
import '../providers/auth.dart';
import '../providers/user_info.dart';
import '../widgets/main_drawer.dart';
import '../widgets/cart_panel.dart';
import '../widgets/cart_total_box.dart';
import '../widgets/address_dialog.dart';
import '../screens/orders_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final deliveryCharge = 4.99;
  Map<String, dynamic>? paymentIntentData;

  @override
  Widget build(BuildContext context) {
    var order = Provider.of<Order>(context);
    final auth = Provider.of<Auth>(context);
    var addressProvider = Provider.of<UserInfo>(context);
    final mQuery = MediaQuery.of(context);
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    // ScreenUtil.init(
    //   BoxConstraints(
    //     maxHeight: mQuery.size.height,
    //     maxWidth: mQuery.size.width,
    //   ),
    //   designSize: Size(390, 844),
    //   orientation: Orientation.portrait,
    // );
    return Scaffold(
      backgroundColor: Color(0xFFffffff),
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Cart'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                _buildHeader(isIOS, mQuery),
                Container(
                  child: order.orderItems.length == 0
                      ? Center(
                          child: Text(
                            'Your cart is empty!',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemBuilder: (c, i) {
                            return CartPanel(order.orderItems[i]);
                          },
                          itemCount: order.orderItems.length,
                        ),
                  height: isIOS
                      ? mQuery.size.height * 0.51
                      : mQuery.size.height * 0.52,
                ),
              ],
            ),
            _buildTotalSection(order, mQuery, isIOS, () async {
              if (order.orderItems.length == 0) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('The cart is empty! Please add some items'),
                  ),
                );
                return;
              }
              if (!addressProvider.haveInfo()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Please add address details'),
                  ),
                );
                return;
              }

              try {
                final gTotal = (grandTotal(order, deliveryCharge));
                int oId = auth.activeOrderId;
                await makePayment(makeInt(gTotal));
                var totalPrice = gTotal.toStringAsFixed(2);
                await order.placeOrder(context, totalPrice, oId);
                await Provider.of<Order>(context, listen: false)
                    .fetchOrders(context);
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              } catch (e) {}
            }),
          ],
        ),
      ),
    );
  }

  double grandTotal(order, deliveryCharge) {
    return order.subTotal() * 1.06 + deliveryCharge;
  }

  int makeInt(num) {
    String st = num.toStringAsFixed(2);
    final len = st.length;
    String substr = st.substring(0, len - 3) + st.substring(len - 2, len);
    int x = int.parse(substr);
    print(x);
    print(x.runtimeType);
    return x;
  }

  Future<void> makePayment(amt) async {
    final url = Uri.parse(
        "https://us-central1-rodhospayment123.cloudfunctions.net/stripePayment?amount=$amt");

    final response = await http.get(
      url,
      headers: {
        'Content-type': 'application/json',
      },
    );

    paymentIntentData = json.decode(response.body);

    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['paymentIntent'],
          applePay: true,
          googlePay: true,
          testEnv: true,
          style: ThemeMode.light,
          merchantCountryCode: 'CA',
          merchantDisplayName: 'Rodhos Pizza'),
    );
    setState(() {});
    await Stripe.instance.presentPaymentSheet();
  }

  Widget _buildTotalSection(order, mQuery, isIOS, onTap) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 3),
          CartTotalBox('SubTotal', order.subTotal()),
          CartTotalBox('Taxes', order.subTotal() * 0.06),
          CartTotalBox('Delivery', deliveryCharge),
          CartTotalBox('Grand Total', grandTotal(order, deliveryCharge)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildOrderButton("Address", () {
                showDialog(
                  context: context,
                  barrierColor: Colors.transparent,
                  builder: (c) {
                    return AddressDialog();
                  },
                );
              }),
              _buildOrderButton("Place Order", onTap),
            ],
          ),
        ],
      ),
      height: isIOS ? mQuery.size.height * 0.25 : mQuery.size.height * 0.27,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        //color: Colors.grey.shade300,
        color: Theme.of(context).primaryColor,
      ),
    );
  }

  Widget _buildOrderButton(label, onTap) {
    return Container(
      width: 150,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          primary: Colors.redAccent.shade100,
          side: BorderSide(
            color: Colors.white,
            width: 1,
          ),
          //textStyle: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildHeader(isIOS, mq) {
    return Container(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              'Dish',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 45,
          ),
          Expanded(
            child: Text(
              'Quantity',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Text(
            'Price',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        vertical: 5,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 5,
          ),
        ),
      ),
    );
  }
}
