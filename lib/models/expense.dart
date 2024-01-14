import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

enum ItemCategory { food, travel, leisure, work }

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
