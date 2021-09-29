// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';

class ContactForm extends StatefulWidget {
  Map userData;
  ContactForm({Key? key, required this.userData}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  @override
  void initState() {
    super.initState();
    if (widget.userData["hasData"]) {
      
      username.text = widget.userData["userInfo"]["details_customer"]
              ["customer"]["name"] ??
          "";
      email.text = widget.userData["userInfo"]["details_customer"]["customer"]
              ["email"] ??
          "";
      email.text = email.text == "null" ? "" : email.text;
      
    } 
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController message = TextEditingController();
  final ApiClientRepository repository = Modular.get<ApiClientRepository>();
  bool showScreen = true;

  void sendMessage() async {
    setState(() {
      showScreen = false;
      // print("entrou1");
    });
    // ignore: prefer_typing_uninitialized_variables
    var result;
    try {
      result =
          await repository.sendMessage(username.text, email.text, message.text);
    } catch (e) {
      print("error on DB");
      print(e);
      setState(() {
        // print("entrou2");
        showScreen = true;
      });
      return showDialogAlert(
        context: context,
        title: "Message",
        message: "Erro trying to send the message, please try later",
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

    result = jsonDecode(result.toString());

    if (result['error'] == true) {
      setState(() {
        // print("entrou3");
        showScreen = true;
      });

      return showDialogAlert(
        context: context,
        title: "Message",
        message: result['message'],
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
      // print("entrou4");
      showScreen = true;
    });
    // print(result);
    return showDialogAlert(
      context: context,
      title: "Message",
      message: "Thank you for sending us a message. We will reply it soon.",
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
                controller: username,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'name' must be filled.";
                  }

                  return null;
                },
                label: "Name",
                keyboardType: TextInputType.name,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: email,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'Email' must be filled.";
                  }
                  if (!value.contains('@') && value != "") {
                    return "Field 'Email' invalid.";
                  }
                  return null;
                },
                label: "Email",
                keyboardType: TextInputType.visiblePassword,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 4,
                maxLines: 4,
                isReadOnly: false,
                controller: message,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'Message' must be filled.";
                  }
                  return null;
                },
                label: "Message",
                keyboardType: TextInputType.visiblePassword,
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
                  text: "SEND",
                  buttonColor: const Color(0xFF4f4d1f),
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      sendMessage();
                    }
                  },
                ),
              ),
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
