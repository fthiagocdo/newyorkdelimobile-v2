// ignore_for_file: avoid_print

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';
import 'package:new_york_delivery_app/app/views/Contact%20Me%20Screen/components/Contact%20Form/contact_form.dart';
import 'package:new_york_delivery_app/app/views/Sign%20up%20screen/components/Form/signup_form.dart';

class ContactMeScreen extends StatefulWidget {
  const ContactMeScreen({Key? key}) : super(key: key);

  @override
  _ContactMeScreenState createState() => _ContactMeScreenState();
}

class _ContactMeScreenState extends State<ContactMeScreen> {
  ApiClientRepository apiClientRepository = Modular.get<ApiClientRepository>();
  Map data = {"firebaseInfo": {}, "userInfo": {}};
  

  Future<void> showContactMeScreen() async {
    User? user;
    try {
      user = await initializeFirebaseLogin();
    } catch (e) {
      print(e);
      print("We had some problems with firebase connection, please try later");
      
    }
    if (user != null) {
      // ignore: prefer_typing_uninitialized_variables
      data["firebaseInfo"] = user;
      // ignore: prefer_typing_uninitialized_variables
      var result;
      try {
        result = await apiClientRepository.getUser("email", user.uid);
      } catch (e) {
        print(e);
        print(
            "We had some problems trying to connect our DB, please try later");
      }
      data["userInfo"] = result.data;
      data["hasData"] = true;
    }else{
      data["hasData"] = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    int randomNumber = Random().nextInt(6) + 1;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contact us",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      drawer: const Menu(),
      body: SafeArea(
        child: FutureBuilder(
          future: showContactMeScreen(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.white,
                      ),
                      padding: const EdgeInsets.all(15.0),
                      margin: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            height: 105.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  'assets/images/contactus/0$randomNumber.jpg',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          const SizedBox(
                            child: Divider(
                              height: 10.0,
                              color: Color(0xFF4f4d1f),
                            ),
                            // width: 250.0,
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          ContactForm(
                            userData: data 
                          ),
                          // const SignUpForm()
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
