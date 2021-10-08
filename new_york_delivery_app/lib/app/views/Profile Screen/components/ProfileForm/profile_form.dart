import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';

class ProfileForm extends StatefulWidget {
  Map userData = {};
  ProfileForm({Key? key, required this.userData}) : super(key: key);
  @override
  _ProfileFormState createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  ApiClientRepository apiClientRepository = Modular.get<ApiClientRepository>();
  UserModel userModel = Modular.get<UserModel>();
  final _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirm_password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController postcode = TextEditingController();
  final TextEditingController address = TextEditingController();
  String photoURL = "";
  bool receiveNotification = false;
  bool showPassword = false;
  bool showConfirmPassword = false;
  bool showScreen = true;

  @override
  void initState() {
    username.text = widget.userData["userInfo"]["details_customer"]["customer"]
            ["name"] ??
        "";
    // username.text = username.text == "null" ? "" : username.text;
    postcode.text = widget.userData["userInfo"]["details_customer"]["customer"]
            ["postcode"] ??
        "";
    postcode.text = postcode.text == "null" ? "" : postcode.text;
    email.text = widget.userData["userInfo"]["details_customer"]["customer"]
            ["email"] ??
        "";
    email.text = email.text == "null" ? "" : email.text;
    address.text = widget.userData["userInfo"]["details_customer"]["customer"]
            ["address"] ??
        "";
    address.text = address.text == "null" ? "" : address.text;
    phone.text = widget.userData["userInfo"]["details_customer"]["customer"]
            ["phone_number"] ??
        "";
    phone.text = phone.text == "null" ? "" : phone.text;
    photoURL = widget.userData['firebaseInfo'].photoURL ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void changeUserInfo() async {
      setState(() {
        showScreen = false;
      });
      try {
        if (password.text.isNotEmpty) {
          try {
            changePassword(userModel.password, password.text);
          } catch (e) {
            throw Exception("Error on Firebase");
          }
        }

        // ignore: prefer_typing_uninitialized_variables
        var teste;
        // print(widget.userData["userInfo"]["details_customer"]["customer"]
        //           ["id"]);
        // print(username.text);
        // print(phone.text);
        // print(postcode.text.isEmpty);
        // print(address.text.isEmpty);
        // print(widget.userData["userInfo"]["details_customer"]["customer"]
        //           ["provider"]);
        // return ;
        try {
          teste = await apiClientRepository.updateUser(
              widget.userData["userInfo"]["details_customer"]["customer"]["id"]
                  .toString(),
              username.text,
              phone.text.isEmpty ? "" : phone.text.toString(),
              postcode.text.isEmpty ? "" : postcode.text.toString(),
              address.text.isEmpty ? "" : address.text.toString(),
              receiveNotification == true ? "1" : "0",
              widget.userData["userInfo"]["details_customer"]["customer"]
                  ["provider"]);
        } catch (e) {
          print(e);
          throw Exception("Error on DB");
        }
        print(teste.data);
        if (teste.data["message"] ==
            "Creating default object from empty value") {
          throw Exception("Error on DB");
        }
      } catch (e) {
        print(e);
        setState(() {
          showScreen = true;
        });
        await showDialogAlert(
          context: context,
          title: "Message",
          message:
              "It was not possible complete your request. Please try again later...",
          actions: [
            Center(
              child: MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "OK",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 100.0,
                onPress: () {
                  Navigator.popUntil(context, ModalRoute.withName('/Menu'));
                },
              ),
            ),
          ],
        );
      }
      setState(() {
        showScreen = true;
      });

      Modular.to.pop();
    }

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
                    return "Field 'username' must be filled.";
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
                isReadOnly: true,
                controller: email,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'Email' must be filled.";
                  }

                  if (!value.contains("@")) {
                    return "Field 'Email' must be valid.";
                  }

                  return null;
                },
                label: "Email",
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
                minLines: 1,
                maxLines: 1,
                isReadOnly: userModel.password == "" ? true : false,
                controller: password,
                validation: (value) {
                  if (userModel.password != "" &&
                      (value == null || value.isEmpty)) {
                    return "Field 'password' must be filled.";
                  }
                  if (userModel.password != "" && (value!.length < 8)) {
                    return "Password must be at least 8 characters long.";
                  }
                  if (userModel.password != "" && (value!.length > 32)) {
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
                      ? const Icon(Icons.lock,
                          size: 25.0, color: Color(0xFF4f4d1f))
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
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: userModel.password == "" ? true : false,
                controller: confirm_password,
                validation: (value) {
                  if (userModel.password != "" &&
                      (value == null || value.isEmpty)) {
                    return "Field 'confirmPassword' must be filled.";
                  }
                  if (userModel.password != "" &&
                      (value != confirm_password.text)) {
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
                      showConfirmPassword = !showConfirmPassword;
                    });
                  },
                  child: showConfirmPassword
                      ? const Icon(Icons.lock,
                          size: 25.0, color: Color(0xFF4f4d1f))
                      : const Icon(
                          Icons.lock_open,
                          size: 25.0,
                          color: Color(0xFF4f4d1f),
                        ),
                ),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: showConfirmPassword,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: phone,
                validation: (value) {
                  if (value!.length > 15) {
                    return "Phone must be a maximum of 15 characters.";
                  }
                  return null;
                },
                label: "Phone Number",
                keyboardType: TextInputType.phone,
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
                controller: postcode,
                validation: (value) {
                  return null;
                },
                label: "Post Code",
                keyboardType: TextInputType.text,
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
                controller: address,
                validation: (value) {
                  return null;
                },
                label: "Address",
                keyboardType: TextInputType.streetAddress,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                      side: const BorderSide(color: Colors.lightGreen),
                      checkColor: Colors.black, // color of tick Mark
                      activeColor: Colors.grey,
                      value: receiveNotification,
                      onChanged: (newValue) {
                        setState(() {
                          receiveNotification = newValue!;
                        });
                      }),
                  const Text(
                    "Receive Notification?",
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              Center(
                child: MainButton(
                  sizeWidth: 150.0,
                  brand: const Icon(Icons.add),
                  hasIcon: false,
                  text: "CONFIRM",
                  buttonColor: const Color(0xFF4f4d1f),
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      print("Entreiiiii");
                      changeUserInfo();
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
