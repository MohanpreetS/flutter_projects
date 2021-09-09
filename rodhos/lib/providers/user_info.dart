import 'package:flutter/material.dart';

class UserInfo with ChangeNotifier {
  String addressLine1;
  String addressLine2;
  String city;
  String postalCode;

  UserInfo({
    this.addressLine1 = '',
    this.addressLine2 = '',
    this.city = '',
    this.postalCode = '',
  });

  bool haveInfo() {
    if (addressLine1 == '' || city == '' || postalCode == '') {
      return false;
    }
    return true;
  }

  void setValues(a1, a2, c, p) {
    addressLine1 = a1;
    addressLine2 = a2;
    city = c;
    postalCode = p;
  }
}
