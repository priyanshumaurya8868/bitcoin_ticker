import 'package:flutter/material.dart';
import 'price_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        appBarTheme: const AppBarTheme(
          backgroundColor:Colors.lightBlue,
              shadowColor: Colors.lightBlue
        ),
          colorScheme: const ColorScheme.dark(
              secondary: Colors.lightBlue,
          ),
          scaffoldBackgroundColor: Colors.white),

      home: PriceScreen(),
    );
  }
}
