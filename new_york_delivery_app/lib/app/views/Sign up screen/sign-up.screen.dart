import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';

import 'components/Form/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      // drawer: const Menu(),
      body: SafeArea(
        child: FutureBuilder(
          future: initializationFirebase(),
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
                          padding: const EdgeInsets.all(15.0),
                          margin: const EdgeInsets.all(15.0),
                          child: Column(
                            children: const [
                              SizedBox(
                                height: 10.0,
                              ),
                              SignUpForm()
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }else{
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
