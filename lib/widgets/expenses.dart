import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: "Fultter course",
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: "Cinema",
      amount: 12.99,
      date: DateTime.now(),
      category: Category.food,
    ),
  ];

  // this function shows a modal when the + button is pressed
  void _openAddExpenseOverlay() {
    // context and builder is required
    // context is a global variable which is enabled by flutter inside a State class
    // what is context : widget meta data managed by flutter(position of overall widget tree)
    // builder must be provided with a function

    // ctx is the context of the modal bottm sheet that was created
    // context is the context of the _ExpensesState
    showModalBottomSheet(
      context: context,
      builder: (ctx) => const NewExpense(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // scaffold has a app bar official support
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Expense Tracker"),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const Text("Chart"),

          // why do we use Expanded here ? Because column(or column like widget) inside a
          // column does not rendered accurately
          Expanded(
            child: ExpensesList(
              expeses: _registeredExpenses,
            ),
          ),
        ],
      ),
    );
  }
}
