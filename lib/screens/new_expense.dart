import 'package:expensetracker/widgets/back_button.dart';
import 'package:expensetracker/widgets/text_input_card.dart';
import 'package:expensetracker/widgets/title_text.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({
    required this.addExpense,
    super.key,
  });

  final void Function(Expense expense) addExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ItemCategory? _selectedCategory;

  void _selectDate() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: now);

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitSelectedData() {
    //try parse change string text to number if it cant it returns null
    final enteredAmount = double.tryParse(_amountController.text);
    final isAmountValid = (enteredAmount == null || enteredAmount <= 0.0);
    if (_titleController.text.trim().isEmpty ||
        isAmountValid ||
        _selectedDate == null ||
        _selectedCategory == null) {
      //show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, data and category was entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }

    final newExpense = Expense(
        amount: enteredAmount,
        title: _titleController.text,
        category: _selectedCategory!,
        dateTime: _selectedDate!);

    // Add the new expense to the list of registered expenses.
    widget.addExpense(newExpense);

    // Close the bottom sheet.
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          toolbarHeight: 100,
          leading: CustomBackButton(
            close: () {
              Navigator.of(context).pop();
            },
          ),
          title: const AppBarTitle(appbarTitleText: 'Expenses list'),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                TextInputCard(
                  titleController: _titleController,
                  hintText: 'Enter title',
                  keyBoardType: TextInputType.text,
                ),
                const SizedBox(
                  height: 15,
                ),
                TextInputCard(
                  titleController: _amountController,
                  hintText: 'Enter Amount',
                  keyBoardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //date selection button
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                        ),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            shape: const BeveledRectangleBorder(),
                            padding: const EdgeInsets.all(
                                16), // Increase button size
                          ),
                          label: Text(
                            _selectedDate == null
                                ? 'Select Date'
                                : _selectedDate.toString().substring(0, 10),
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .color),
                          ),
                          onPressed: _selectDate,
                          icon: Icon(
                            Icons.date_range_rounded,
                            size: 30,
                            color:
                                Theme.of(context).textTheme.titleLarge!.color,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 17, vertical: 7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(),
                          color: Colors.transparent,
                        ),
                        child: DropdownButton(
                          iconSize: 30,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color:
                                Theme.of(context).textTheme.titleLarge?.color,
                          ),
                          value: _selectedCategory,
                          items: ItemCategory.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category.name.toUpperCase(),
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              _selectedCategory = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    fixedSize: const Size(150, 50),
                  ),
                  onPressed: _submitSelectedData,
                  child: const Text('Save Expese'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
