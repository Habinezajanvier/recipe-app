import 'package:flutter/material.dart';
import 'package:recipeapp/providers/recipes.dart';
import './screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe app',
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        brightness: Brightness.dark,
      ),
      home: const MyHomePage(title: 'Recipe App'),
    );
  }
}
