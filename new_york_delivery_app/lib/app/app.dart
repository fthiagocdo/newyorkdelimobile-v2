import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/login.screen.dart';

class NewWorkDeliApp extends StatelessWidget {
  const NewWorkDeliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.lightGreen[900],
      ),
      title: "New Work Deli",
      home: const LoginScreen(),
    );
  }
}
