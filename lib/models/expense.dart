import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import "package:intl/intl.dart";

final formatter = DateFormat.yMd();

const uuid = Uuid();

enum Category { leisure, work, travel, food }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expsenses});

  ExpenseBucket.forCategory(List<Expense> allExpsenses, this.category)
      : expsenses = allExpsenses
            .where((expense) => expense.category == category)
            .toList();

  final Category category;
  final List<Expense> expsenses;

  double get totalExpenses {
    double sum = 0.0;

    for (Expense expense in expsenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
