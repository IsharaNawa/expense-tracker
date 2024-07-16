import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  // dispose must be called on every controller otherwise memeory would not be released
  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // add the date picker
  void _presentDatePicker() {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
                    Text("Selected date"),
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
          Row(
            children: [
              TextButton(
                onPressed: () {
                  // we should use the Navigator to the original screen
                  // this would disappear the modal overlay
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  print(titleController.text);
                  print(amountController.text);
                },
                child: const Text("Save Expense"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
