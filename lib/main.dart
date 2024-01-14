import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/add_button.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: Expenses());
  }
}

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
      category: Category.work,
    ),
    Expense(
      amount: 389,
      dateTime: DateTime.now(),
      title: 'dart course',
      category: Category.work,
    ),
    Expense(
      amount: 920,
      dateTime: DateTime.now(),
      title: 'Pizza',
      category: Category.food,
    ),
    Expense(
      amount: 540,
      dateTime: DateTime.now(),
      title: 'pune',
      category: Category.travel,
    ),
  ];

  void onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>
          const Text('Hello'), // Replace with your bottom sheet content
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
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
                  onTap: () {
                    Navigator.of(context).pop();
                  },
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
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: const Center(
        child: Text('This is the second screen!'),
      ),
    );
  }
}
