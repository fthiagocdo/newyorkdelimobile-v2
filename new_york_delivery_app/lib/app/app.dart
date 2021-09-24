import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/src/presenters/modular_base.dart';

class NewWorkDeliApp extends StatelessWidget {
  const NewWorkDeliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF4f4d1f),
        appBarTheme: const AppBarTheme(color: Color(0xFF4f4d1f))   
      ),
      title: "New Work Deli",
      initialRoute: "/Login",
    ).modular();
  }
}
