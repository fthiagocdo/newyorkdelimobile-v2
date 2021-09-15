import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainButton extends StatelessWidget {
  const MainButton({Key? key, required this.text, required this.onPress, required this.buttonColor, this.sizeWidth = 250.0, required this.brand, required this.hasIcon}) : super(key: key);
  final bool hasIcon;
  final Widget brand;
  final String text;
  final Function() onPress;
  final Color buttonColor;
  final double sizeWidth;

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
        width: sizeWidth,
        height: 30.0,
        child: Center(
          child: hasIcon? brand :  Text(
            text,
          ),
        ),
      ),
    );
  }
}
