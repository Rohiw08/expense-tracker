import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/back_button.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ExpensesListPage extends StatelessWidget {
  final List<Expense> expenseslist;
  final void Function(Expense) newRemoveFunction;

  const ExpensesListPage({
    Key? key,
    required this.expenseslist,
    required this.newRemoveFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 55),
          Row(
            children: [
              CustomBackButton(
                close: () {
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(width: 75),
              const AppBarTitle(appbarTitleText: 'Expenses list'),
            ],
          ),
          ExpensesList(
            expenses: expenseslist,
            removeFunction: newRemoveFunction, // Use the newRemoveFunction here
          ),
        ],
      ),
    );
  }
}
