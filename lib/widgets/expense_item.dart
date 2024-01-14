import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {Key? key}) : super(key: key);

  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 1),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Icon(
              ItemCategoryIcons[expense.category],
              color: Colors.white,
            ),
          ),
          title: Text(
            expense.title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          subtitle: Text(
            'Category: ${expense.category}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '\$${expense.amount.toString()}',
                style: GoogleFonts.varelaRound(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                expense.dateTime.toString().substring(0, 10),
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
