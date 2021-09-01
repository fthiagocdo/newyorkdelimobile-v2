import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/app.dart';
import 'package:new_york_delivery_app/app/app.modular.dart';

void main() {
  runApp(ModularApp(module: AppModule(),child: const NewWorkDeliApp()));
}
