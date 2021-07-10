import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../templates/tint_container.dart';
import '../providers/motivators.dart';

class AddRpSheet extends StatefulWidget {
  bool isReward;
  AddRpSheet({required this.isReward});
  @override
  _AddRpSheetState createState() => _AddRpSheetState();
}

class _AddRpSheetState extends State<AddRpSheet> {
  final detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var hint;
  bool isReason = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final motivators = Provider.of<Motivators>(context);
    return TintContainer(
      color: Colors.white,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.25,
        child: Form(
          child: Container(
            padding: EdgeInsets.only(top: 3, right: 3, left: 3),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  margin: const EdgeInsets.only(
                    top: 10,
                    right: 5,
                    left: 5,
                    bottom: 5,
                  ),
                  child: TextFormField(
                    autofocus: true,
                    controller: detailsController,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.isReward
                          ? isReason
                              ? 'Write your reason to succeed here'
                              : 'Write your concrete reward here'
                          : isReason
                              ? 'Write your reason to not fail here'
                              : 'Write your concrete punishment here',
                      hintStyle: TextStyle(
                        color: Colors.blueGrey.shade50,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                    ),
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value == null || value.length < 1) {
                        return 'Please enter some text';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.isReward
                          ? 'Concrete \n Reward'
                          : ' Concrete \nPunishment',
                      style: isReason
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                          : TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                    ),
                    Switch(
                      value: isReason,
                      activeColor: Colors.white,
                      activeTrackColor: Colors.black38,
                      inactiveTrackColor: Colors.black38,
                      onChanged: (value) {
                        setState(
                          () {
                            isReason = value;
                            print(isReason);
                          },
                        );
                      },
                    ),
                    Text(
                      widget.isReward
                          ? 'Reason to \n succeed'
                          : 'Reason to \n not fail',
                      softWrap: true,
                      style: !isReason
                          ? TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            )
                          : TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                _buildDoneButton(
                    formKey, size, motivators, widget.isReward, isReason),
              ],
            ),
          ),
          key: formKey,
        ),
      ),
    );
  }

  Widget _buildDoneButton(formKey, size, motivators, isReward, isReason) {
    return GestureDetector(
      onTap: () {
        final isValid = formKey.currentState.validate();
        if (isValid) {
          if (isReward) {
            motivators.addReward(detailsController.text, isReason);
          } else {
            motivators.addPunishment(detailsController.text, isReason);
          }
          setState(() {});
          Navigator.of(context).pop();
        }
      },
      child: Container(
        child: Center(
          child: Text(
            'Done',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
        height: 50,
        width: size.width * 0.3,
        margin: EdgeInsets.only(bottom: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: LinearGradient(
            colors: [Colors.lightBlue, Colors.purpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }
}
