import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expeses, required this.deleteExpenseFromList});

  final List<Expense> expeses;
  final void Function(Expense expense) deleteExpenseFromList;

  @override
  Widget build(BuildContext context) {
    // we can use a column for fixed size length
    // but we use a list in which the length we dont know, we need to use other widget
    // otherwise the performance of the app would be less
    // Column all the items rendered at once, where we use the other Widget, only the appered widget would be rendered

    // we can use ListView also for rendring a list which we dont know the lenth, but this also renderes at once

    // we can use builder method of ListView for the maximum optimization

    // itemBuilder would be using the list and builds each item of the list
    return ListView.builder(
        itemCount: expeses.length,
        itemBuilder: (ctx, index) =>
            // we added the dismissable action to the expenses list
            // so the users can swipe and dismiss the expenses item
            Dismissible(
              key: ValueKey(expeses[index]),
              background: Container(
                color: Theme.of(context).colorScheme.error.withOpacity(0.75),
                margin: EdgeInsets.symmetric(
                  horizontal: Theme.of(context).cardTheme.margin!.horizontal,
                ),
              ),
              onDismissed: (direction) =>
                  {deleteExpenseFromList(expeses[index])},
              child: ExpenseItem(expeses[index]),
            ));
  }
}
