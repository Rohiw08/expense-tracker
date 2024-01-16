import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/screens/new_expense.dart';
import 'package:expensetracker/widgets/title_text.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [];

  Widget mainContent = const Center(
    child: Text('No expense found. Start Adding some'),
  );

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(expenseIndex, expense);
            });
          },
        ),
      ),
    );
  }

  void onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: NewExpense(
          addExpense: _addExpense,
        ),
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeFunction: _removeExpense,
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            toolbarHeight: 100,
            // leading: const CustomBackButton(),
            title: const AppBarTitle(appbarTitleText: 'Activity'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: mainContent,
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(18.0),
          child: FloatingActionButton(
            onPressed: onAddButtonPressed,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
