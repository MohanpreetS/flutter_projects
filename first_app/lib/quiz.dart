import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final quesns;
  final Function ansQues;
  final int index;
  Quiz(this.quesns, this.ansQues, this.index);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Question(quesns[index]['questions']),
        ...(quesns[index]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return Answer(() => ansQues(answer['score']), answer['text']);
        }).toList()
      ],
    );
  }
}
