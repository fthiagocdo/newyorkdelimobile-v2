import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';

Future<void> ShowDialog(
    {required String title,
    required String message,
    required BuildContext context,
    required List<Widget> actions}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SizedBox(
          width: 150.0,
          height: 80.0,
          child: Center(
            child: Text(message),
          ),
        ),
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: actions,
          )
        ],
      );
    },
  );
}
