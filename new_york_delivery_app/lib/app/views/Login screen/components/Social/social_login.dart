import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/SocialButton/social_button.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({Key? key, required this.onPressGoogle, required this.onPressFacebook}) : super(key: key);
  final Function() onPressGoogle;
  final Function() onPressFacebook;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: SocialButton(
              side:"Left",              
              hasIcon: true,
              brand: const Image(
                  height: 30.0,
                  image: AssetImage('assets/images/icons/google_social.png')),
              text: "Google",
              onPress: onPressGoogle,
              buttonColor: const Color.fromRGBO(221,76,57, 1),
              sizeWidth: 100.0,
            ),
          ),
          Expanded(
            child: SocialButton(
              side:"Right",
              hasIcon: true,
              brand: const Icon(
                Icons.facebook,
                size: 25.0,
              ),
              text: "Facebook",
              onPress: onPressFacebook,
              buttonColor: Colors.blueAccent,
              sizeWidth: 100.0,
            ),
          )
        ],
      ),
    );
  }
}
