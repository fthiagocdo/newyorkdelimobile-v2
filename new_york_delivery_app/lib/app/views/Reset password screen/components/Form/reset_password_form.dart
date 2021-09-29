import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({Key? key}) : super(key: key);

  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool showPassword = false;
  bool showScreen = true;

  void _resetPassword() async {
    setState(() {
      showScreen = false;
    });
    try {
      await sendPasswordResetEmail(_emailController.text);
    } catch (e) {
      print(e);
      print("Error on DB");
      setState(() {
        showScreen = true;
      });
      return showDialogAlert(
        title: "message",
        message: 'Error on DB, please try later',
        context: context,
        actions: [
          Center(
            child: MainButton(
              brand: const Icon(Icons.add),
              hasIcon: false,
              text: "OK",
              buttonColor: const Color(0xFF4f4d1f),
              sizeWidth: 100.0,
              onPress: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );
    }
    setState(() {
      showScreen = true;
    });
    return showDialogAlert(
      title: "message",
      message:
          'Please verify your mailbox to find an e-mail to help you to reset your password.',
      context: context,
      actions: [
        Center(
          child: MainButton(
            brand: const Icon(Icons.add),
            hasIcon: false,
            text: "OK",
            buttonColor: const Color(0xFF4f4d1f),
            sizeWidth: 100.0,
            onPress: () {
              Navigator.popUntil(context, ModalRoute.withName('/Login'));
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: _emailController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'email' must be filled.";
                  }
                  if (!value.contains('@') && value != "") {
                    return "Field 'Email' invalid.";
                  }
                  return null;
                },
                label: "E-mail",
                keyboardType: TextInputType.emailAddress,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: MainButton(
                  brand: const Icon(Icons.add),
                  hasIcon: false,
                  sizeWidth: 150,
                  text: "CONFIRM",
                  buttonColor: const Color(0xFF4f4d1f),
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      _resetPassword();
                    }
                  },
                ),
              )
            ],
          ),
        ),
        if (!showScreen)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Center(
                child: Container(
                  width: 90.0,
                  height: 90.0,
                  padding: const EdgeInsets.all(5),
                  child: const CircularProgressIndicator(
                    strokeWidth: 5.0,
                    color: Color(0xFF4f4d1f),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
