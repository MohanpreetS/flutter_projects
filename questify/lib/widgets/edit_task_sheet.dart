import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../templates/tint_container.dart';
import '../providers/tasks.dart';

class EditTaskSheet extends StatefulWidget {
  final oldTaskName;
  final oldTaskDetails;
  final taskId;
  EditTaskSheet({this.oldTaskName, this.oldTaskDetails, this.taskId});
  @override
  _EditTaskSheetState createState() => _EditTaskSheetState();
}

class _EditTaskSheetState extends State<EditTaskSheet> {
  var taskNameController = TextEditingController();
  var taskDetailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    taskNameController.text = widget.oldTaskName;
    taskDetailController.text = widget.oldTaskDetails;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var tasks = Provider.of<Tasks>(context);
    return TintContainer(
      color: Colors.white,
      opacity: 0.5,
      child: Container(
        height: size.height * 0.3,
        child: Column(
          children: [
            Form(
              key: formKey,
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
                      controller: taskNameController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Task title',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade300,
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
                  Container(
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
                      controller: taskDetailController,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Task details (optional)',
                        hintStyle: TextStyle(
                          color: Colors.grey.shade300,
                          fontSize: 18,
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                      ),
                      onFieldSubmitted: (_) {
                        final isValid = formKey.currentState?.validate();
                        if (isValid != null && isValid) {
                          tasks.editTask(
                            widget.taskId,
                            taskNameController.text,
                            taskDetailController.text,
                          );
                          setState(() {});
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.access_time_filled,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                _buildDoneButton(size, formKey, tasks, taskNameController,
                    taskDetailController),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.flag,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoneButton(
      size, formKey, tasks, taskNameController, taskDetailController) {
    return GestureDetector(
      onTap: () {
        final isValid = formKey.currentState.validate();
        if (isValid) {
          if (isValid != null && isValid) {
            tasks.editTask(
              widget.taskId,
              taskNameController.text,
              taskDetailController.text,
            );
            setState(() {});
            Navigator.of(context).pop();
          }
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
        //margin: EdgeInsets.only(bottom: 25),
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
