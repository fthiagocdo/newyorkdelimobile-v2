import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'components/Form/reset_password_form.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({ Key? key }) : super(key: key);

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reset Password",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
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
                              ResetPasswordForm(),
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
                child: CircularProgressIndicator(color: Color(0xFF4f4d1f)),
              );
            }
          },
        ),
      ),
    );
  }
}