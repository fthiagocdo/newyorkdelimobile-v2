import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';

Future<void>ShowDialog ({ required String title, required String message, String buttonMessage = "Ok", required  BuildContext context,required  Function() onPress}) async {
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
            Center(
              child: MainButton(
                text: buttonMessage,
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 100.0,
                onPress: onPress,
              ),
            ),
          ],
        );
      },
    );
  }