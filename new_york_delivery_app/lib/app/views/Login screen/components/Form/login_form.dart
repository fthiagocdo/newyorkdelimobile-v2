// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/Social/social_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    void _login() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('keepLogged', keepLogged);

      User? user = await signInUsingEmailPassword(
        email: _emailController.text,
        password: _passwordController.text,
        context: context,
      );
      if (user != null) {
        if (!user.emailVerified) {
          showDialogAlert(
            title: "Message",
            message: "Email not verified. Resend email verification?",
            context: context,
            actions: [
              MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "YES",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 50.0,
                onPress: () async {
                  await user.sendEmailVerification();
                  showDialogAlert(
                    title: "Message",
                    message:
                        "Please validate your email address. Kindly check your inbox.",
                    context: context,
                    actions: [
                      Center(
                        child: MainButton(
                          brand: const Icon(Icons.add),
                          hasIcon: false,
                          sizeWidth: 80,
                          text: "OK",
                          buttonColor: const Color(0xFF4f4d1f),
                          onPress: () async {
                            Navigator.popUntil(
                                context, ModalRoute.withName('/Login'));
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
              MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "NO",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 50.0,
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
          return;
        }
        // Response result;
        // try {
        //   result = await _clientRepository.getUser(
        //       _emailController.text, _passwordController.text);
        // } catch (e) {
        // ignore: avoid_print
        //   print("Error on DB, please try later");
        // ignore: avoid_print
        //   print(e);
        // }
        // Modular.to.navigate("Menu", arguments: result);
      } else {}
    }

    void _loginGoogle() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('keepLogged', keepLogged);
      var user;
      try {
        user = await signInWithGoogle();
      } catch (e) {
        print(e);
        print("Error trying to login with Google, please login later");
      }

      if (user != null) {
        var result;
        try {
          result = await _clientRepository.findOrCreateUser(
              user.user!.email.toString(), user.user!.uid, "google");
        var teste = await _clientRepository.updateUser('${result.data['details_customer']['customer']['id']}', user.additionalUserInfo.profile["name"], "", "", "", "1", "google");
        } catch (e) {
          print("Error on DB, please try later");
          print(e);
        }
        // print("Google");
        // Modular.to.navigate('/Menu', arguments: user);

      } else {
        showDialogAlert(
          title: "Message",
          message:
              "We had a error trying to connect to Google, please try later",
          context: context,
          actions: [
            MainButton(
              sizeWidth: 70.0,
              brand: const Icon(Icons.add),
              hasIcon: false,
              text: "OK",
              buttonColor: const Color(0xFF4f4d1f),
              onPress: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    }

    void _loginFacebook() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('keepLogged', keepLogged);
      // ignore: prefer_typing_uninitialized_variables
      var user;
      try {
        user = await signInWithFacebook();
      } catch (e) {
        print("Error trying to login with facebook, please login later");
        print(e);
      }

      // ignore: unnecessary_null_comparison
      if (user != null) {
        print("Facebook");
        // print(user);
        // print(user.additionalUserInfo);
        // print(user.additionalUserInfo.profile);
        // print(user.user.uid);
        // print(user.user);
        // print(user.user.phoneNumber);
        // print(user.additionalUserInfo.profile["email"]);
        // print(user.additionalUserInfo.profile["name"]);
        // print(user.additionalUserInfo.profile["picture"]["data"]["url"]);
        // print(user.credential);
        // print(user.credential.signInMethod);
        // print(user.additionalUserInfo.name);
        
        // ignore: prefer_typing_uninitialized_variables
        var result;
        var teste;
        try {
          result = await _clientRepository.findOrCreateUser(
              user.additionalUserInfo.profile["email"],
              user.user.uid,
              user.credential.signInMethod);
          // ! We must change the user data on the DB, using facebook's info
           teste = await _clientRepository.updateUser('${result.data['details_customer']['customer']['id']}', user.additionalUserInfo.profile["name"], user.user.phoneNumber ?? "", "", "", "1", "facebook");
        } catch (e) {
          print("Error on DB, please try later");
          print(e);
        }
        
        print(result.data);
        print(teste.data);
        // Modular.to.navigate('/Menu',arguments: user);

      } else {
        showDialogAlert(
          title: "Message",
          message:
              "We had a error trying to connect to Facebook, please try later",
          context: context,
          actions: [
            MainButton(
              sizeWidth: 70.0,
              brand: const Icon(Icons.add),
              hasIcon: false,
              text: "OK",
              buttonColor: const Color(0xFF4f4d1f),
              onPress: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    }

    return Column(
      children: [
        Form(
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
                isReadOnly: false,
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
                isReadOnly: false,
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
                          color: Color(0xFF4f4d1f),
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
                    onTap: () {
                      Modular.to.pushNamed('/Reset-password');
                    },
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
                  sizeWidth: 330.0,
                  brand: const Icon(Icons.add),
                  hasIcon: false,
                  text: "LOG IN",
                  buttonColor: const Color(0xFF4f4d1f),
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          child: Divider(
            color: Color(0xFF4f4d1f),
          ),
          // width: 250.0,
        ),
        SocialLogin(
          onPressGoogle: _loginGoogle,
          onPressFacebook: _loginFacebook,
        )
      ],
    );
  }
}
