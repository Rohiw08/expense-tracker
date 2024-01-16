import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum ItemCategory { food, travel, leisure, work }

// ignore: constant_identifier_names
const ItemCategoryIcons = {
  ItemCategory.food: Icons.lunch_dining,
  ItemCategory.travel: Icons.flight_takeoff,
  ItemCategory.leisure: Icons.movie,
  ItemCategory.work: Icons.work,
};

//data structure to store
class Expense {
  Expense({
    required this.amount,
    required this.title,
    required this.category,
    required this.dateTime,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime dateTime;
  final ItemCategory category;
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expenses});
  final ItemCategory category;
  final List<Expense> expenses;

  //utility constructor function
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  double get totalExpenses {
    double sum = 0;
    for (var expense in expenses) {
      sum += expense.amount;
    }
    return sum;
  }
}
