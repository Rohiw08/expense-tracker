import 'package:expensetracker/main.dart';
import 'package:expensetracker/screens/complete_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/back_button.dart';
import 'package:expensetracker/widgets/charts/chart.dart';
import 'package:expensetracker/widgets/expenses_list.dart';
import 'package:expensetracker/screens/new_expense.dart';
import 'package:expensetracker/widgets/title_text.dart';

class WebLayout extends StatefulWidget {
  const WebLayout({Key? key}) : super(key: key);

  @override
  State<WebLayout> createState() => _WebLayoutState();
}

class _WebLayoutState extends State<WebLayout> {
  final List<Expense> _registeredExpenses = [];

  void onAddButtonPressed() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SizedBox(
        height: MediaQuery.of(ctx).size.height,
        child: NewExpense(
          addExpense: _addExpense,
        ),
      ),
    );
  }

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
    ScaffoldMessenger.of(context).clearSnackBars();
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

  void onViewListButtonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExpensesListPage(
          expenseslist: _registeredExpenses,
          newRemoveFunction: _removeExpense,
        ),
      ),
    );
  }

  Widget? mainContent;

  @override
  Widget build(BuildContext context) {
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        removeFunction: _removeExpense,
      );
    } else {
      mainContent = const Center(
        child: Text('No expense found. Start Adding some'),
      );
    }

    final isLightMode = Theme.of(context).scaffoldBackgroundColor ==
        const Color.fromARGB(255, 247, 238, 241);

    Color colorOfContainer = isLightMode
        ? const Color.fromARGB(255, 247, 226, 234)
        : Theme.of(context).primaryColor;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            toolbarHeight: 100,
            leading: CustomBackButton(
              close: () {
                SystemNavigator.pop();
              },
            ),
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
              ),
            ],
          ),
        ),
        body: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ChartSection(
                  colorOfContainer: colorOfContainer,
                  registeredExpenses: _registeredExpenses),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                        child: Text(
                          'Expenses list',
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: 30,
                        padding: const EdgeInsets.only(right: 20),
                        child: ElevatedButton(
                          onPressed: onViewListButtonPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorOfContainer,
                          ),
                          child: Text(
                            'View List',
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.color),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(child: mainContent!),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
          child: FloatingActionButton(
            onPressed: onAddButtonPressed,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
