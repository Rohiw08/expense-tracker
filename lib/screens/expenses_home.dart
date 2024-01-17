import 'package:expensetracker/main.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/back_button.dart';
import 'package:expensetracker/widgets/charts/chart.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/screens/new_expense.dart';
import 'package:expensetracker/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

    final isLightMode = Theme.of(context).scaffoldBackgroundColor ==
        const Color.fromARGB(255, 247, 238, 241);

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            toolbarHeight: 100,
            leading: CustomBackButton(close: () {
              SystemNavigator.pop();
            }),
            title: const AppBarTitle(appbarTitleText: 'Activity'),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            actions: [
              Switch(
                value: isLightMode,
                onChanged: (value) {
                  // Toggle the theme mode based on the switch value
                  ThemeMode newThemeMode =
                      value ? ThemeMode.light : ThemeMode.dark;
                  // Update the theme mode
                  ExpenseTrackerApp.of(context)!.setThemeMode(newThemeMode);
                },
              ),
              const SizedBox(
                width: 20,
              )
            ],
            // actions: [Switch(value: true, onChanged: changeTheme)],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Material(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  height: 330,
                  decoration: BoxDecoration(
                      color: isLightMode
                          ? const Color.fromARGB(255, 247, 226, 234)
                          : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Chart(expenses: _registeredExpenses),
                ),
              ),
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    'Expenses list',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
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
