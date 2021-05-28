import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int result;
  final Function res;
  Result(this.result, this.res);

  String get resultPhrase {
    var resultText = 'GG';
    if (result <= 15) {
      resultText = 'you did well, you scored ' + result.toString();
    } else {
      resultText = 'Amazing job, you scored ' + result.toString();
    }
    return resultText;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            resultPhrase,
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: res,
            child: Text('Restart quiz'),
            textColor: Colors.amber,
          ),
        ],
      ),
    );
  }
}
