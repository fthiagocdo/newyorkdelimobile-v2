import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key, required this.onPressGoogle, required this.onPressFacebook}) : super(key: key);
  final Function() onPressGoogle;
  final Function() onPressFacebook;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        MainButton(
          hasIcon: true,
          brand: const Image(
              height: 20.0,
              image: AssetImage('assets/images/icons/google_social.png')),
          text: "",
          onPress: onPressGoogle,
          buttonColor: Colors.white,
          sizeWidth: 90.0,
        ),
        MainButton(
          hasIcon: true,
          brand: const Icon(
            Icons.facebook,
            size: 30.0,
          ),
          text: "",
          onPress: onPressFacebook,
          buttonColor: Colors.blueAccent,
          sizeWidth: 90.0,
        )
      ],
    );
  }
}
