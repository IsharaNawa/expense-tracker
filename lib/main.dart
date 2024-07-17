import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

// creating the color scheme
// from seed method would create a different fades of one color
var kColorScheme =
    ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 96, 59, 181));

void main() {
  runApp(
    MaterialApp(
      // we can use a general theme related to the app
      // we can use a theme from scatch or we can use a theme already exists and then
      // override only the parameters we need

      // from scratch : ThemeData(useMaterial3 : true)
      // overriding : ThemeData().copyWith(useMaterial3 : true) here we are copying the existing values
      // and chaning only what we need

      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          // choosing two different colors for background and foreground
          // based on the color scheme
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 4,
          ),
        ),

        // in the elevated button we dont have a copyWith method
        // instead we have to follow the below approach
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),

        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColorScheme.onSecondaryFixed,
                fontSize: 14,
              ),
            ),
      ),

      home: const Expenses(),
    ),
  );
}
