// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/Form/login_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ApiClientRepository apiClientRepository = Modular.get<ApiClientRepository>();

  Widget getLoginScreen() {
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
          Column(
            children: [
              const SizedBox(
                height: 10.0,
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                margin: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFF4f4d1f)),
                        ),
                        GestureDetector(
                          onTap: () {
                            Modular.to.pushNamed('/Sign-up');
                          },
                          child: const Text(
                            "Click Here ",
                            style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 12.0,
                                color: Color(0xFF4f4d1f)),
                          ),
                        ),
                        const Text(
                          "to sign up.",
                          style: TextStyle(
                              fontSize: 12.0, color: Color(0xFF4f4d1f)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const FormLogin(),
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> getKeepLogged() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? keep = prefs.getBool('keepLogged');
    return keep == null ? false : true;
  }

  Future<Map> getLogin() async {
    bool keepUserOn = false;
    try {
      keepUserOn = await getKeepLogged();
    } catch (e) {
      print("Error on SharedPreferences feature, please try later");
      print(e);
    }
    print("passei 1");
    // see if the keep-logged is set to true
    if (keepUserOn == true) {
      // if it's true, them check the firebase
      User? user = await initializeFirebaseLogin();
      if (user != null) {
        
        // if the firebase has data, them check the api to get user's info
        // ignore: prefer_typing_uninitialized_variables
        print("asd");
        print(user.email);
        Response userInfo =
            await apiClientRepository.getUser("email", user.uid.toString());

        print("passei 2");
        // ignore: unused_local_variable,
        // print(userInfo.data);
        // print(userInfo.data.runtimeType );
        var userData = Map<String, dynamic>.from(userInfo.data);

        print(userData);

        // print(jsonDecode(userInfo.data.toString()));
        return userData;
        // var userData = jsonDecode(userInfo.data);
        // if (userData != null) {
        //   print("AQUI");
        // if there is some data in the api, send the user to menu screen
        //   return userData;
        // } else {
        //   print("AQUI2");
        // if there is any data, them send the user to the login screen
        //   return {};
        // }
      } else {
        // if there is no data on firebase, them send the user to the login screen
        print("AQUI3");
        return {"data": false};
      }
    } else {
      print("AQUI4");
      // if is not, them send the the user to the login screen
      return {"data": false};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      drawer: const Menu(),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: getLogin(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              print("Entrei");
              print(snapshot.data);

              if (snapshot.data?["data"] != null) {
                // go to the menu screen with the data

                return const Center(
                  child: Text("go to menu"),
                );
              } else {
                // login screen;
                return getLoginScreen();
              }
            }
            // data is not ready yet!
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
