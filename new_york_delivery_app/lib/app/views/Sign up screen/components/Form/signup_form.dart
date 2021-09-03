import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utlis/show_dialog.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final ApiClientRepository _clientRepository =
      Modular.get<ApiClientRepository>();
  bool showPassword = false;
  bool confirmPassword = false;

  void _signup() async {
    User? user = await registerUsingEmailPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    if (user != null) {
      try {
        // Response result = await _clientRepository.findOrCreateUser(
            // user.email.toString(), user.uid, user.providerData.toString());
      } catch (e) {
        await user.delete();

        return ShowDialog(
          title: "Message",
          message:
              "It was no possible complete your request. Please try again later...",
          context: context,
          actions:[
            Center(
          child: MainButton(
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
      return ShowDialog(
        title: "Message",
        message: 'Please validate your email address. Kindly check your inbox.',
        context: context,
        actions:[
          Center(
          child: MainButton(
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
    } else {
      return ShowDialog(
        title: "Message",
        message:
            "It was no possible complete your request. Please try again later...",
        context: context,
        actions:[
          Center(
          child: MainButton(
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
          TextInput(
            controller: _passwordController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Field 'password' must be filled.";
              }
              if (value.length < 8) {
                return "Password must be at least 8 characters long.";
              }
              if (value.length > 32) {
                return "Password must be a maximum of 32 characters.";
              }
              return null;
            },
            label: "Password",
            keyboardType: TextInputType.visiblePassword,
            hasSuffixIcon: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: showPassword
                  ? const Icon(Icons.lock, size: 25.0, color: Color(0xFF4f4d1f))
                  : const Icon(
                      Icons.lock_open,
                      size: 25.0,
                      color: Color(0xFF4f4d1f),
                    ),
            ),
            cursorColor: const Color(0xFF4f4d1f),
            showContent: showPassword,
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextInput(
            controller: _confirmPasswordController,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Field 'confirmPassword' must be filled.";
              }
              if (value != _passwordController.text) {
                return "Password and Confirm Password do not match.";
              }

              return null;
            },
            label: "Confirm Password",
            keyboardType: TextInputType.visiblePassword,
            hasSuffixIcon: true,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  confirmPassword = !confirmPassword;
                });
              },
              child: confirmPassword
                  ? const Icon(Icons.lock, size: 25.0, color: Color(0xFF4f4d1f))
                  : const Icon(
                      Icons.lock_open,
                      size: 25.0,
                      color: Color(0xFF4f4d1f),
                    ),
            ),
            cursorColor: const Color(0xFF4f4d1f),
            showContent: confirmPassword,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: MainButton(
              sizeWidth: 150,
              text: "CONFIRM",
              buttonColor: const Color(0xFF4f4d1f),
              onPress: () async {
                if (_formKey.currentState!.validate()) {
                  _signup();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
