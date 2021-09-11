import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/views/Login%20screen/components/Form/login_form.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        child: FutureBuilder<bool>(
          future: getKeepLogged(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData && snapshot.data != false) {
                // check if there is data
                return FutureBuilder(
                    future: initializeFirebaseLogin(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        print(snapshot.data);
                        if (snapshot.hasData) {
                          // go to the menu
                          return const Center(child: Text("Go to Menu"),);
                        } else {
                          // go to login
                          return getLoginScreen();
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    });
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
