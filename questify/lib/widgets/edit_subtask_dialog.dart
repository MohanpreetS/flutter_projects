import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../templates/medium_white_container.dart';
import '../screens/task_screen.dart';
import '../providers/tasks.dart';

class EditSubtaskDialog extends StatefulWidget {
  final taskIndex;
  var initialVal;
  final subtaskId;
  EditSubtaskDialog({this.taskIndex, this.initialVal, this.subtaskId});
  @override
  _EditSubtaskDialogState createState() => _EditSubtaskDialogState();
}

class _EditSubtaskDialogState extends State<EditSubtaskDialog> {
  final formKey = GlobalKey<FormState>();
  var detailsController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    detailsController.text = widget.initialVal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context, formKey),
    );
  }

  _buildChild(context, formKey) {
    final size = MediaQuery.of(context).size;
    var tasks = Provider.of<Tasks>(context);
    return MediumWhiteContainer(
      opacity: 0.7,
      child: Form(
        key: formKey,
        child: Container(
          height: size.height * 0.3,
          decoration: BoxDecoration(
            //color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                  right: 5,
                  left: 5,
                ),
                child: TextFormField(
                    controller: detailsController,
                    decoration: InputDecoration(
                        hintText: 'Write your subtask here',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.length < 1) {
                        return 'Please enter some text';
                      } else {
                        return null;
                      }
                    },
                    onFieldSubmitted: (text) {
                      final isValid = formKey.currentState.validate();
                      if (isValid) {
                        tasks.allTasks[widget.taskIndex].editSubtask(
                          widget.subtaskId,
                          detailsController.text,
                        );
                        setState(() {});
                        Navigator.of(context).pop();
                      }
                    }
                    //controller: details,
                    ),
              ),
              _buildDoneButton(tasks, formKey, size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoneButton(tasks, formKey, size) {
    return GestureDetector(
      onTap: () {
        final isValid = formKey.currentState.validate();
        if (isValid) {
          tasks.allTasks[widget.taskIndex].editSubtask(
            widget.subtaskId,
            detailsController.text,
          );
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
