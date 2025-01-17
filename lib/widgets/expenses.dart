import 'package:expense_tracker/widgets/chart/chart.dart';
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

  // this function executes when the user wants to add a new expense to the list
  // this is bind to the button in the modal
  void _addNewExpenseToList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  // this function executes when the user wants to delete the expense item by swiping it
  // this is bind to the button in the modal
  void _deleteExpenseFromList(Expense expense) {
    // first get the index of the item about to be deleted
    final int deletedIndex = _registeredExpenses.indexOf(expense);

    // delete the item
    setState(() {
      _registeredExpenses.remove(expense);
    });

    // clear any existing snackbars
    ScaffoldMessenger.of(context).clearSnackBars();

    // allowing the user to unde the deletion
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      // create the duration for undo message
      duration: const Duration(seconds: 15),

      // main text
      content: const Text("Expense Deleted!"),

      // create the action
      action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              _registeredExpenses.insert(deletedIndex, expense);
            });
          }),
    ));
  }

  // this function shows a modal when the + button is pressed
  void _openAddExpenseOverlay() {
    // context and builder is required
    // context is a global variable which is enabled by flutter inside a State class
    // what is context : widget meta data managed by flutter(position of overall widget tree)
    // builder must be provided with a function

    // ctx is the context of the modal bottm sheet that was created
    // context is the context of the _ExpensesState
    showModalBottomSheet(
      isScrollControlled: true,

      context: context,

      // call the new expense widget
      builder: (ctx) => NewExpense(_addNewExpenseToList),
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
          Chart(expenses: _registeredExpenses),

          // why do we use Expanded here ? Because column(or column like widget) inside a
          // column does not rendered accurately
          Expanded(
            child: _registeredExpenses.isEmpty
                ? const Center(child: Text("No Expenses! Please add some."))
                : ExpensesList(
                    expeses: _registeredExpenses,
                    deleteExpenseFromList: _deleteExpenseFromList,
                  ),
          ),
        ],
      ),
    );
  }
}
