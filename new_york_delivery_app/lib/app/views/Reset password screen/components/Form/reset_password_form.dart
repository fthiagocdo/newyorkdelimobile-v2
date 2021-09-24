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

  void _resetPassword() async {
    await sendPasswordResetEmail(_emailController.text);
    showDialogAlert(
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
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10.0,
          ),
          TextInput(
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
    );
  }
}
