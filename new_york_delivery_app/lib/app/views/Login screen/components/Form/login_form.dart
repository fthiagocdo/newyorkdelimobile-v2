import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormLogin> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool keepLogged = false;
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    ApiClientRepository _clientRepository = Modular.get<ApiClientRepository>();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(
                  side: const BorderSide(color: Colors.lightGreen),
                  checkColor: Colors.black, // color of tick Mark
                  activeColor: Colors.grey,
                  value: keepLogged,
                  onChanged: (newValue) {
                    setState(() {
                      keepLogged = newValue!;
                    });
                  }),
              const Text(
                "Keep me logged",
              ),
            ],
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text(
            "E-mail",
          ),
          TextInput(
            label: "",
            hasSuffixIcon: false,
            suffixIcon: GestureDetector(),
            showContent: true,
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Field 'email' must be filled.";
              }
              if (!value.contains('@') && value != "") {
                return "Field 'Email' invalid.";
              }
              return null;
            },
            cursorColor: Colors.lightGreen,
            keyboardType: TextInputType.emailAddress,
            controller: _emailController,
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Text(
            "Password",
          ),
          TextInput(
            validation: (value) {
              if (value == null || value.isEmpty) {
                return "Field 'password' must be filled.";
              }
              return null;
            },
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            hasSuffixIcon: true,
            label: "",
            showContent: showPassword,
            cursorColor: Colors.lightGreen,
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              child: showPassword
                  ? const Icon(
                      Icons.lock,
                      size: 25.0,
                      color: Color(0xFF4f4d1f)
                    )
                  : const Icon(
                      Icons.lock_open,
                      size: 25.0,
                      color: Color(0xFF4f4d1f),
                    ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {},
                child: const Text(
                  "RESET PASSWORD",
                  style: TextStyle(
                    color: Color(0xFF4f4d1f),
                  ),
                ),
              ),
              const SizedBox(
                width: 10.0,
              )
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: MainButton(
              text: "LOG IN",
              buttonColor: Color(0xFF4f4d1f),
              onPress: () async {
                  
                if (_formKey.currentState!.validate()) {
                  
                  User? user = await signInUsingEmailPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context,
                  );
                  if (user != null) {
                    Response result = await _clientRepository.getUser(_emailController.text, _passwordController.text);
                    print("Passei");
                  }else{
                    
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
