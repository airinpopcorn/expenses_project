import 'package:expenses_project/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blueGrey,
          accentColor: Colors.amber,
        ),
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
                titleMedium: const TextStyle(
              fontFamily: "OpenSans",
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
        )),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [];

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime choosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: choosenDate,
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (buildCtx) {
        return NewTransaction(_addNewTransaction);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.4,
              child: Chart(
                recentTransaction: _recentTransactions,
              ),
            ),
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.6,
              child: TransactionList(
                _userTransactions,
                _deleteTransaction,
              ),
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
