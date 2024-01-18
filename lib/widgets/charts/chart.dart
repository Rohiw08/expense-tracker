import 'package:expensetracker/models/expense.dart';
import 'package:expensetracker/widgets/charts/chart_bar.dart';
import 'package:flutter/material.dart';

class ChartSection extends StatelessWidget {
  const ChartSection({
    super.key,
    required this.colorOfContainer,
    required List<Expense> registeredExpenses,
  }) : _registeredExpenses = registeredExpenses;

  final Color colorOfContainer;
  final List<Expense> _registeredExpenses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Material(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: double.maxFinite,
          decoration: BoxDecoration(
            color: colorOfContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Chart(expenses: _registeredExpenses),
        ),
      ),
    );
  }
}

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, ItemCategory.food),
      ExpenseBucket.forCategory(expenses, ItemCategory.leisure),
      ExpenseBucket.forCategory(expenses, ItemCategory.travel),
      ExpenseBucket.forCategory(expenses, ItemCategory.work),
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (final bucket in buckets) {
      if (bucket.totalExpenses > maxTotalExpense) {
        maxTotalExpense = bucket.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 120, // Adjust the height as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalExpenses == 0
                        ? 0
                        : bucket.totalExpenses / maxTotalExpense,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        ItemCategoryIcons[bucket.category],
                        color: Theme.of(context).textTheme.titleLarge?.color,
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}
