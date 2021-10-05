import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/views/Choose%20A%20Deli%20Screen/components/CardDeli/card_deli.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseADeliScreen extends StatefulWidget {
  const ChooseADeliScreen({Key? key}) : super(key: key);

  @override
  _ChooseADeliScreenState createState() => _ChooseADeliScreenState();
}

class _ChooseADeliScreenState extends State<ChooseADeliScreen> {
  ApiClientRepository repository = Modular.get<ApiClientRepository>();

  Future<List> getShopsList() async {
    var result;
    try {
      result = await repository.listShops(true);
    } catch (e) {
      print(e);
      print("Error on API");
    }
    return jsonDecode(result.toString())['list'];
  }

  @override
  void initState() {
    getShopsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
      
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Choose a Deli",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      drawer: const Menu(),
      body: SafeArea(
        child: FutureBuilder<User?>(
          future: initializeFirebaseLogin(),
          builder: (context, snapshotFirebase) {
            if (snapshotFirebase.connectionState == ConnectionState.done) {
              return Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      "assets/images/background.png",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: FutureBuilder<List>(
                  future: getShopsList(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, item) {
                          return CardDeli(
                            deliID: snapshot.data![item]['id'],
                            deliName: snapshot.data![item]['name'],
                            address: snapshot.data![item]['address'],
                            onTap: () async{
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              // print('${snapshot.data![item]['id']}');
                              prefs.setInt('menuTypes', snapshot.data![item]['id'] as int);
                              Modular.to.pushNamed("/Menu-Types");
                              
                            },
                          );                              
                        },
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
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
