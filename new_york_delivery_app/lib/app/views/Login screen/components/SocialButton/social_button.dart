import 'package:flutter/material.dart';

class SocialButton extends StatelessWidget {
  const SocialButton(
      {Key? key,
      required this.text,
      required this.onPress,
      required this.buttonColor,
      this.sizeWidth = 250.0,
      required this.brand,
      required this.hasIcon,
      required this.side})
      : super(key: key);
  final bool hasIcon;
  final Widget brand;
  final String text;
  final Function() onPress;
  final Color buttonColor;
  final double sizeWidth;
  final String side;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: side == "Left"
              ? const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  bottomLeft: Radius.circular(30.0))
              : const BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
        ),
      ),
      child: SizedBox(
        width: sizeWidth,
        height: 30.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            hasIcon ? brand : const SizedBox(),
            const SizedBox(width: 10.0),
            Text(
              text,
            ),
          ],
        ),
      ),
    );
  }
}
