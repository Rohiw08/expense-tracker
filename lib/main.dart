import 'package:expensetracker/screens/expenses_home.dart';
import 'package:flutter/material.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 237, 179, 199),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  runApp(const ExpenseTrackerApp());
}

class ExpenseTrackerApp extends StatefulWidget {
  const ExpenseTrackerApp({super.key});

  static _ExpenseTrackerAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ExpenseTrackerAppState>();

  @override
  _ExpenseTrackerAppState createState() => _ExpenseTrackerAppState();
}

class _ExpenseTrackerAppState extends State<ExpenseTrackerApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void setThemeMode(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: kColorScheme,
        scaffoldBackgroundColor: const Color.fromARGB(255, 247, 238, 241),
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: const TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        scaffoldBackgroundColor:
            Theme.of(context).snackBarTheme.backgroundColor,
        appBarTheme: const AppBarTheme().copyWith(
          titleTextStyle: const TextStyle(color: Colors.white),
        ),
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: const Expenses(),
    );
  }
}
