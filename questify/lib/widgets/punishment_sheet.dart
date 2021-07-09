import 'package:flutter/material.dart';

import '../models/reward.dart';
import '../templates/tint_container.dart';
import '../models/task.dart';

class PunishmentSheet extends StatefulWidget {
  Task currentTask;

  PunishmentSheet(this.currentTask);

  @override
  _PunishmentSheetState createState() => _PunishmentSheetState();
}

class _PunishmentSheetState extends State<PunishmentSheet> {
  final punishmentController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final size = mQuery.size;
    return TintContainer(
      color: Colors.red,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.4,
        decoration: BoxDecoration(
          //color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        padding: EdgeInsets.only(
          top: 10,
          left: 10,
          right: 10,
        ),
        child: Column(
          children: [
            if (widget.currentTask.punishments.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some punishments for not doing this task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (widget.currentTask.punishments.isNotEmpty)
              Expanded(
                child: ListView(
                  children: widget.currentTask.punishments
                      .map((e) => _buildPunishmentText(e.details))
                      .toList(),
                ),
              ),
            Form(
              key: formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                margin: EdgeInsets.only(
                  top: 5,
                  right: 5,
                  left: 5,
                  bottom: 20,
                ),
                child: TextFormField(
                  controller: punishmentController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Add punishment',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade300,
                      fontSize: 18,
                    ),
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.length < 1) {
                      return 'Please enter some text';
                    } else {
                      return null;
                    }
                  },
                  onFieldSubmitted: (text) {
                    final validated = formKey.currentState?.validate();
                    if (validated != null && validated) {
                      widget.currentTask.addPunishment(text);
                    }
                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPunishmentText(details) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        children: [
          WidgetSpan(
            child: Container(
              //padding: const EdgeInsets.symmetric(horizontal: 2.0),
              child: Icon(
                Icons.not_interested,
                color: Colors.white,
                size: 23,
              ),
            ),
          ),
          TextSpan(text: ' $details')
        ],
      ),
    );
  }
}
