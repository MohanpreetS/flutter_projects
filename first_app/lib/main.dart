import 'package:flutter/material.dart';

import 'quiz.dart';
import './result.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _quesns = const [
    {
      'questions': 'Q1',
      'answers': [
        {'text': 'a11', 'score': 5},
        {'text': 'a12', 'score': 8},
        {'text': 'a13', 'score': 10},
      ]
    },
    {
      'questions': 'Q2',
      'answers': [
        {'text': 'a21', 'score': 4},
        {'text': 'a22', 'score': 6},
        {'text': 'a23', 'score': 8},
      ]
    },
    {
      'questions': 'Q3',
      'answers': [
        {'text': 'a31', 'score': 5},
        {'text': 'a32', 'score': 7},
        {'text': 'a33', 'score': 3},
      ]
    }
  ];
  var _index = 0;
  var _total = 0;

  void _ansQues(int score) {
    _total += score;
    setState(() {
      _index = _index + 1;
    });
  }

  void _reset() {
    setState(() {
      _index = 0;
      _total = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('First app'),
        ),
        body: _index < _quesns.length
            ? Quiz(_quesns, _ansQues, _index)
            : Result(_total, _reset),
      ),
    );
  }
}
