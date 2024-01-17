import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {Key? key, required this.expenses, required this.removeFunction})
      : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) removeFunction;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: expenses.length,
        itemBuilder: (ctx, index) => Dismissible(
              key: ValueKey(
                expenses[index],
              ),
              onDismissed: (direction) {
                removeFunction(
                  expenses[index],
                );
              },
              child: ExpenseItem(
                expenses[index],
              ),
            ));
  }
}
