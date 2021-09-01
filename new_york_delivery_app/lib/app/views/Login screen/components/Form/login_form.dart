import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/TextInput/text_input.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormLogin> {
  String email = "";
  String password = "";
  bool keepLogged = false;
  bool showPassword = false;
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
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
              return "";
            },
            cursorColor: Colors.lightGreen,
            keyboardType: TextInputType.emailAddress,
            onChange: (String? value) {
              setState(() {
                email = value!;
              });
            },
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
            },
            onChange: (String? value) {
              setState(() {
                password = value!;
              });
            },
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
                    )
                  : const Icon(
                      Icons.lock_open,
                      size: 25.0,
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
                    color: Colors.lightGreen,
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
              buttonColor: Colors.lightGreen,
              onPress: () {
                if (_formKey.currentState!.validate()) {}
              },
            ),
          ),
        ],
      ),
    );
  }
}
