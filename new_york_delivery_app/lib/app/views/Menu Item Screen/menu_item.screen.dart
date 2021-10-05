// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/views/Menu%20Item%20Screen/components/ItensMenu/itens_menu.dart';

class MenuItemScreen extends StatefulWidget {
  final int menuTypeID;
  const MenuItemScreen({Key? key, required this.menuTypeID}) : super(key: key);

  @override
  _MenuItemScreenState createState() => _MenuItemScreenState();
}

class _MenuItemScreenState extends State<MenuItemScreen> {
  ApiClientRepository repository = Modular.get<ApiClientRepository>();
  bool showScreen = true;
  Future<Map> hasExtraOrChoice(String menuItemID) async {
    Map data = {"menuExtras": {}, "menuChoices": {}};
    var extraData;
    var choicesData;
    try {
      extraData = await repository.getMenuExtras(menuItemID);
      choicesData = await repository.getMenuChoices(menuItemID);
      print(extraData.data);
      print("\n");
      print(choicesData.data);
      if (extraData.data['error'] && choicesData.data['error']) {
        throw Exception("Error on DB");
      }
    } catch (e) {
      print(e);
    }

    if (extraData.data['message'] == "No records found." &&
        choicesData.data['message'] == "No records found.") {
      return {"data": false};
    } else {
      data['menuExtras'] = extraData.data;
      data['menuChoices'] = choicesData.data;
      data['data'] = true;
      return data;
    }
  }

  Future<Map> getMenuItensDeli() async {
    Map data = {"itens": [], "fotoUrl": ""};
    var result;

    try {
      result = await repository.getMenuItens(widget.menuTypeID.toString());
    } catch (e) {
      print("Error on BD");
      print(e);
    }
    if (result.data['error'] == false) {
      data['itens'] = jsonDecode(result.toString())['list'];
      return data;
    } else {
      Modular.to.popAndPushNamed("/Menu");
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Menu",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder<Map>(
          future: getMenuItensDeli(),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 150.0,
                      width: double.infinity,
                      child: Image.network(
                        'http://www.ftcdevsolutions.com/newyorkdelidelivery/api/menuitem/image/${widget.menuTypeID}',
                        fit: BoxFit.fill,
                        height: 100.0,
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: snapshot.data!['itens']!.length,
                        itemBuilder: (context, index) {
                          return ItensMenu(
                            itemName: snapshot.data!['itens']![index]
                                ['name'],
                            price: snapshot.data!['itens']![index]['price'],
                            onTap: () async {
                              Map goToMenuChoiceExtra =
                                  await hasExtraOrChoice(snapshot
                                      .data!['itens']![index]['id']
                                      .toString());
                              if (goToMenuChoiceExtra['data'] == true) {
                                Modular.to.pushNamed("/Menu-Choice-Extras",
                                    arguments: goToMenuChoiceExtra);
                              } else {
                                print("Não possui extras ou Choices");
                              }
                            },
                          );
                        },
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
