import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/src/presenters/modular_base.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/login.screen.dart';

class NewWorkDeliApp extends StatelessWidget {
  const NewWorkDeliApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFF4f4d1f),
        
      ),
      title: "New Work Deli",
      initialRoute: "/Sign-up",
      // home: const LoginScreen(),
    ).modular();
  }
}
