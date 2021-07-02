import 'package:flutter/material.dart';

import '../models/reward.dart';
import '../templates/tint_container.dart';
import '../models/task.dart';

class RewardSheet extends StatefulWidget {
  Task currentTask;

  RewardSheet(this.currentTask);

  @override
  _RewardSheetState createState() => _RewardSheetState();
}

class _RewardSheetState extends State<RewardSheet> {
  final rewardController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    final size = mQuery.size;
    return TintContainer(
      color: Colors.yellowAccent.shade700,
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
            if (widget.currentTask.rewards.isEmpty)
              Expanded(
                child: Center(
                  child: Text(
                    'Add some rewards for this task',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            if (widget.currentTask.rewards.isNotEmpty)
              Expanded(
                child: ListView(
                  children: widget.currentTask.rewards
                      .map((e) => _buildRewardText(e.details))
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
                  controller: rewardController,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      hintText: 'Add reward',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade300,
                        fontSize: 18,
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide.none)),
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
                      widget.currentTask.addReward(text);
                    }

                    setState(() {});
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRewardText(details) {
    return Text(
      '★ $details',
      style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
