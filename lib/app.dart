import 'package:flutter/material.dart';

import 'package:best_of_cooking/ui/screens/home.dart';
import 'package:best_of_cooking/ui/screens/main.dart';
import 'package:best_of_cooking/ui/theme.dart';

class RecipesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Best of Cooking',
      theme: buildTheme(),
      initialRoute: '/home',
      routes: {
        // If you're using navigation routes, Flutter needs a base route.
        // We're going to change this route once we're ready with
        // implementation of HomeScreen.
        '/': (context) => MainScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}