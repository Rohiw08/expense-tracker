import 'package:expensetracker/widgets/add_button.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
        amount: 389,
        dateTime: DateTime.now(),
        title: 'flutter course',
        category: Category.work),
    Expense(
        amount: 389,
        dateTime: DateTime.now(),
        title: 'dart course',
        category: Category.work),
    Expense(
        amount: 920,
        dateTime: DateTime.now(),
        title: 'Pizza',
        category: Category.food),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            leading: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      size: 20,
                      Icons.arrow_back_ios_rounded,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            title: Text(
              'Activity',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            centerTitle: true, // Center the title
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ExpensesList(
                expenses: _registeredExpenses,
              ),
            ],
          ),
          bottomNavigationBar: const AddButton(),
        ),
      ),
    );
  }
}
