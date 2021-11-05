import 'dart:async';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';

class SplashScreenStartApp extends StatefulWidget {
  const SplashScreenStartApp({Key? key}) : super(key: key);

  @override
  _SplashScreenStartAppState createState() => _SplashScreenStartAppState();
}

class _SplashScreenStartAppState extends State<SplashScreenStartApp> {
  UserModel userModel = Modular.get<UserModel>();
  ApiClientRepository repository = Modular.get<ApiClientRepository>();


  Future<Object> loadFromFuture() async {
    await Future.delayed(const Duration(seconds: 5));
    User? user;
    try {
      user = await initializeFirebaseLogin();
    } catch (e) {
      print(e);
      print("We had some problems with firebase connection, please try later");
    }
    if (user != null) {
      String provider = '';
      if(user.providerData[0].providerId == "google.com" || user.providerData[0].providerId == "facebook.com"){
        provider = user.providerData[0].providerId.split(".")[0];
      }
      provider = user.providerData[0].providerId;
      var result;
      try {
        result = await repository.getUser(provider, user.uid);
      } catch (e) {
        print(e);
        print(
            "We had some problems trying to connect our DB, please try later");
      }

      userModel.id = result.data['details_customer']['customer']['id'].toString();
        userModel.provider =
            result.data['details_customer']['customer']['provider'];
        userModel.providerId =
            result.data['details_customer']['customer']['provider_id'];
        userModel.password = "";
      Modular.to.popAndPushNamed('/Menu-Types');
      return {};
    }

    Modular.to.popAndPushNamed('/Login');
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      showLoader: true,
      logoSize: 120,
      logo: Image.asset('assets/images/splash.png',fit: BoxFit.cover,),
      backgroundImage: const AssetImage('assets/images/background.png'),
      futureNavigator: loadFromFuture(),
    );
  }
}
