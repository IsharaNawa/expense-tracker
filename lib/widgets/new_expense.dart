import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.addNewExpenseToList, {super.key});

  // this function handles the binding mechanism
  final void Function(Expense expense) addNewExpenseToList;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  // dispose must be called on every controller otherwise memeory would not be released
  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final double? amount = double.tryParse(amountController.text);
    final bool amountIsInvalid = amount == null || amount <= 0;

    if (titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      // open a dialog box
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input!"),
                content: const Text(
                    "Please make sure a valid title, amount , date and category was enetered!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text("OK"),
                  )
                ],
              ));
      return;
    }

    // when a valid expense is found
    // create a new expense
    Expense submittedExpense = Expense(
        title: titleController.text.trim(),
        amount: amount,
        date: _selectedDate!,
        category: _selectedCategory);

    // call the add method in the expenses file
    widget.addNewExpenseToList(submittedExpense);

    // and pop out the model
    Navigator.pop(context);
  }

  // add the date picker
  // since the function has a future, we need to use async keyword
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // since this returns a future, need to use await here
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );

    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              // wrap the text field with exapnded
              // because it gives some errors(similar to nested cols/rows)
              Expanded(
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: "\$ ",
                    label: Text("Amount"),
                  ),
                ),
              ),
              const SizedBox(
                width: 16,
              ),

              // wrap with expanded to avoid rows for nested Row
              Expanded(
                child: Row(
                  // push the widgets to the end of the row
                  mainAxisAlignment: MainAxisAlignment.end,

                  // center widgets vertically
                  crossAxisAlignment: CrossAxisAlignment.center,

                  children: [
                    Text(_selectedDate == null
                        ? "No Date Selected"
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // drop down button has two essential buttons
              // drop down button does not support controller
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase())))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == null) {
                      return;
                    }
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  // we should use the Navigator to the original screen
                  // this would disappear the modal overlay
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
