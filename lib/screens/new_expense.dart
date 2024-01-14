import 'package:expensetracker/widgets/back_button.dart';
import 'package:expensetracker/widgets/title_text.dart';
import 'package:expensetracker/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  NewExpense({
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

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 70,
        ),
        const Row(
          children: [
            CustomBackButton(),
            SizedBox(
              width: 80,
            ),
            AppBarTitle(
              appbarTitleText: 'Add Expense',
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
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
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 1),
                      ),
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,

                          padding:
                              const EdgeInsets.all(16), // Increase button size
                        ),
                        label: Text(
                          _selectedDate == null
                              ? 'Select Date'
                              : _selectedDate.toString().substring(0, 10),
                        ),
                        onPressed: _selectDate,
                        icon: const Icon(Icons.date_range_rounded, size: 30),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 7),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: Colors.black),
                      ),
                      child: DropdownButton(
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_drop_down),
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
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, fixedSize: Size(150, 50)),
                onPressed: _submitSelectedData,
                child: const Text('Save Expese'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TextInputCard extends StatelessWidget {
  const TextInputCard(
      {super.key,
      required TextEditingController titleController,
      required this.hintText,
      required this.keyBoardType})
      : _controller = titleController;

  final TextEditingController _controller;
  final String hintText;
  final TextInputType keyBoardType;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _controller,
          keyboardType: keyBoardType,
          maxLength: 50,
          decoration: InputDecoration(
            hintText: hintText,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.transparent),
            ),
            contentPadding: const EdgeInsets.only(top: 20, left: 12),
          ),
        ),
      ),
    );
  }
}
