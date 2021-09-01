import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.text, required this.onPress, required this.buttonColor}) : super(key: key);

  final String text;
  final Function() onPress;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: SizedBox(
        width: 250,
        height: 30.0,
        child: Center(
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
