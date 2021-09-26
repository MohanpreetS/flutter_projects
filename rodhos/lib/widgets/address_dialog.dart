import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';

class AddressDialog extends StatefulWidget {
  @override
  _AddressDialogState createState() => _AddressDialogState();
}

class _AddressDialogState extends State<AddressDialog> {
  final address1Controller = TextEditingController();
  final address2Controller = TextEditingController();
  final cityController = TextEditingController();
  final postalController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool invalid = false;

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final userProvider = Provider.of<UserInfo>(context);
    _setPreviousValues(userProvider);

    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 18),
        height: invalid ? 450 : 360,
        width: mQuery.size.width * 0.95,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildField(
                  controller: address1Controller, label: "Address Line 1"),
              _buildField(
                  controller: address2Controller,
                  label: "Address Line 2",
                  empty: true),
              _buildField(controller: cityController, label: "City"),
              _buildField(controller: postalController, label: "Postal Code"),
              SizedBox(height: 20),
              _buildButton(userProvider)
            ],
          ),
        ),
      ),
    );
  }

  void _setPreviousValues(userProvider) {
    address1Controller.text = userProvider.addressLine1;
    address2Controller.text = userProvider.addressLine2;
    cityController.text = userProvider.city;
    postalController.text = userProvider.postalCode;
  }

  Widget _buildButton(userProvider) {
    return GestureDetector(
      onTap: () {
        if (!_formKey.currentState!.validate()) {
          invalid = true;
          setState(() {});
          return;
        }

        Navigator.pop(context);
        userProvider.setValues(
          address1Controller.text,
          address2Controller.text,
          cityController.text,
          postalController.text,
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 60),
        height: 30,
        width: 60,
        child: Center(
          child: Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildField({controller, label, empty = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        validator: (String? val) {
          if (val!.isEmpty && !empty) {
            return "$label is required";
          }
        },
      ),
    );
  }
}
