import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/task_screen.dart';
import '../providers/tasks.dart';

class AddTaskDialog extends StatefulWidget {
  final taskIndex;
  AddTaskDialog({this.taskIndex});
  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  String details = '';
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(context) {
    final size = MediaQuery.of(context).size;
    var tasks = Provider.of<Tasks>(context);
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 16,
            sigmaY: 16,
          ),
          child: Container(
            //margin: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.7),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                width: 1,
                color: Colors.white.withOpacity(0.25),
              ),
            ),
            child: Form(
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
                        decoration: InputDecoration(
                            hintText: 'Write your subtask here',
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none)),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.multiline,
                        onChanged: (val) {
                          setState(() {
                            details = val;
                          });
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        tasks.allTasks[widget.taskIndex].addSubtask(details);
                        setState(() {});
                        Navigator.of(context)
                            .popAndPushNamed(TaskScreen.routeName);
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
