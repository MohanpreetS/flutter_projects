import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
//import 'package:flutter/services.dart';

import './widgets/new_transaction.dart';
import './widgets/list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expensio',
      home: MyHomePage(),
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.blue.shade400,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   title: 'Shoes',
    //   amount: 50.01,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'grocery',
    //   amount: 23.45,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((element) {
      return element.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNew(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: title,
        amount: amount,
        date: chosenDate);
    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTx(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  void _startNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(_addNew);
        });
  }

  List<Widget> _buildLandscape(AppBar appBar, Widget txListWidget) {
    return [
      Row(
        children: [
          Text('Show chart'),
          Switch.adaptive(
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      _showChart
          ? Container(
              child: Chart(_userTransactions),
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.7,
            )
          : txListWidget
    ];
  }

  List<Widget> _buildPortrait(AppBar appBar, Widget txListWidget) {
    return [
      Container(
        child: Chart(_userTransactions),
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.3,
      ),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isL = MediaQuery.of(context).orientation == Orientation.landscape;
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Expensio'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Expensio'),
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startNewTransaction(context),
              ),
            ],
          );

    final txListWidget = Container(
      child: TransactionList(_recentTransactions, _deleteTx),
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.7,
    );

    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isL) ..._buildLandscape(appBar, txListWidget),
            if (!isL) ..._buildPortrait(appBar, txListWidget),
          ],
        ),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startNewTransaction(context),
                  ),
          );
  }
}
