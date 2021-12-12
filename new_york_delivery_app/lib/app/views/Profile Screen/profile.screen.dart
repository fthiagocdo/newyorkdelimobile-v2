import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';
import 'package:new_york_delivery_app/app/views/Profile%20Screen/components/ProfileForm/profile_form.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  ApiClientRepository apiClientRepository = Modular.get<ApiClientRepository>();
  // ! This is just for propose of testing
  // Map<String,String> data = {
  //   "name":"Carlos Alberto",
  //   "email":"carlos@carlos.com",
  //   "password":"carlos",
  //   "postcode":"CA2-123",
  //   "phone":"123-1234",
  //   "address":"Rua ASD 123"
  // };
  Map data = {"firebaseInfo": {}, "userInfo": {}};
  @override
  Widget build(BuildContext context) {
    Future<void> erroAlert() {
      return showDialogAlert(
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

    Future<bool> showProfileScreen() async {
      User? user;
      try {
        user = await initializeFirebaseLogin();
      } catch (e) {
        print(e);
        print(
            "We had some problems with firebase connection, please try later");
        erroAlert();
      }
      if (user != null) {
        // ignore: prefer_typing_uninitialized_variables
        data["firebaseInfo"] = user;
        var result;
        try {
          result = await apiClientRepository.getUser("email", user.uid);
        } catch (e) {
          print(e);
          print(
              "We had some problems trying to connect our DB, please try later");
          erroAlert();
        }
        data["userInfo"] = result.data;
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: GestureDetector(
              child: const Icon(Icons.shopping_cart_outlined),
              onTap: () {
                Modular.to.pushNamed("/Checkout");
              },
            ),
          ),
        ],
        title: const Text(
          "Profile",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      drawer: const Menu(),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/images/background.png",
              ),
              fit: BoxFit.fill,
            ),
          ),
          child: FutureBuilder(
            future: showProfileScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.data == true) {
                print("teste");
                print(snapshot.data);
                return ListView(
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
                          ProfileForm(
                            userData: data,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator(color: Color(0xFF4f4d1f)));
              }
            },
          ),
        ),
      ),
    );
  }
}
