import 'package:expensetracker/screens/expenses_home.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 237, 179, 199),
);

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatelessWidget {
  const ExpenseTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
          useMaterial3: true,
          colorScheme: kColorScheme,
          scaffoldBackgroundColor: Color.fromARGB(255, 247, 238, 241)),
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    );
  }
}
