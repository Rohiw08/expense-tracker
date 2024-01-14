import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/add_button.dart';
import 'package:expensetracker/widgets/back_button.dart';
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

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
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
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: AppBar(
            toolbarHeight: 100,
            leading: const CustomBackButton(),
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
              child: ExpensesList(
                expenses: _registeredExpenses,
              ),
            ),
          ],
        ),
        bottomNavigationBar: GestureDetector(
          onTap: onAddButtonPressed,
          child: const AddButton(),
        ),
      ),
    );
  }
}
