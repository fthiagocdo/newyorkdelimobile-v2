// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/services/firebase/firebase_auth.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';
import 'package:new_york_delivery_app/app/views/Menu%20Extra-Choice%20Screen/components/ItemCheckbox/item_checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExtraChoiceScreen extends StatefulWidget {
  final Map menuItens;
  const ExtraChoiceScreen({Key? key, required this.menuItens})
      : super(key: key);

  @override
  _ExtraChoiceScreenState createState() => _ExtraChoiceScreenState();
}

class _ExtraChoiceScreenState extends State<ExtraChoiceScreen> {
  UserModel userModel = Modular.get<UserModel>();
  ApiClientRepository repository = Modular.get<ApiClientRepository>();
  List checkboxExtrasData = [];
  List checkboxChoiceData = [];
  bool showScreen = true;

  List<int> extrasMenu = [];
  int choicesMenu = 0;

  void addExtra(int newExtra) {
    extrasMenu.add(newExtra);
  }

  @override
  void initState() {
    if (widget.menuItens['menuExtras']['list'].length != 0) {
      checkboxExtrasData = widget.menuItens['menuExtras']['list']
          .map((extra) => {"data": extra, "value": false})
          .toList();
    }

    if (widget.menuItens['menuChoices']['list'].length != 0) {
      checkboxChoiceData = widget.menuItens['menuChoices']['list']
          .map((extra) => {"data": extra, "value": false})
          .toList();
    }

    super.initState();
  }

  Future<void> sendOrder() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? shopID = prefs.getInt('menuTypes');

    var result;
    print("\n");
    print(shopID);
    // print(extrasMenu);
    // print(choicesMenu);
    // print(userModel.id);
    // print(checkboxExtrasData[0]['data']['menuitem_id']);

    try {
      result = await repository.addMenuItem(
        userModel.id,
        shopID.toString(),
        checkboxExtrasData[0]['data']['menuitem_id'],
        extrasMenu,
        choicesMenu,
      );
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Need an extra?",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: const Icon(Icons.shopping_cart_outlined),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/background.png",
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  widget.menuItens['menuExtras']['list'].length != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Add some Extras",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "KGBrokenVesselsSketch",
                                      color: Color(0xFF4f4d1f),
                                    ),
                                  ),
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(203, 178, 154, 1),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: ListView.builder(
                                  itemCount: checkboxExtrasData.length,
                                  itemBuilder: (context, itens) {
                                    return ItemCheckbox(
                                      isTrue: checkboxExtrasData[itens]
                                          ['value'],
                                      title: checkboxExtrasData[itens]['data']
                                          ['name'],
                                      price: checkboxExtrasData[itens]['data']
                                          ['price'],
                                      onTap: (bool? newValue) {
                                        print(newValue);
                                        // print(checkboxExtrasData[itens]['data']['id']);
                                        checkboxExtrasData[itens]['value'] =
                                            !checkboxExtrasData[itens]['value'];
                                        if (newValue == true) {
                                          setState(() {
                                            addExtra(checkboxExtrasData[itens]
                                                ['data']['id']);
                                          });
                                        } else {
                                          setState(() {
                                            extrasMenu.remove(
                                                checkboxExtrasData[itens]
                                                    ['data']['id']);
                                          });
                                        }
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 90.0,
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                  widget.menuItens['menuChoices']['list'].length != 0
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                child: const Padding(
                                  padding: EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    "Add some Choices",
                                    style: TextStyle(
                                      fontSize: 20.0,
                                      fontFamily: "KGBrokenVesselsSketch",
                                      color: Color(0xFF4f4d1f),
                                    ),
                                  ),
                                ),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(203, 178, 154, 1),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: ListView.builder(
                                  itemCount: widget
                                      .menuItens['menuChoices']['list'].length,
                                  itemBuilder: (context, itens) {
                                    print(checkboxChoiceData[itens]['data']);

                                    return ItemCheckbox(
                                      title: checkboxChoiceData[itens]['data']
                                          ['name'],
                                      price: "",
                                      isTrue: checkboxChoiceData[itens]['data']
                                                  ['id'] ==
                                              choicesMenu
                                          ? true
                                          : false,
                                      onTap: (bool? newValue) {
                                        if (newValue == false) {
                                          choicesMenu = 0;
                                        }
                                        setState(() {
                                          checkboxChoiceData[itens]['value'] =
                                              !checkboxChoiceData[itens]
                                                  ['value'];
                                          choicesMenu =
                                              checkboxChoiceData[itens]['data']
                                                  ['id'];
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(
                                height: 90.0,
                              )
                            ],
                          ),
                        )
                      : const SizedBox(),
                  Positioned(
                    bottom: 10.0,
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(100.0)),
                        color: Color(0xFF4f4d1f),
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          setState(() {
                            showScreen = false;
                          });
                          User? user = await initializeFirebaseLogin();
                          print(user);
                          if (user == null) {
                            Navigator.pushNamedAndRemoveUntil(context, '/Login',
                                ModalRoute.withName('/Login'));
                            return;
                          }
                          setState(() {
                            showScreen = true;
                          });
                          return showDialogAlert(
                              title: "Message",
                              message:
                                  "Do you want to buy something else or go to checkout?",
                              context: context,
                              actions: [
                                const SizedBox(
                                  width: 10.0,
                                ),
                                MainButton(
                                  brand: const Icon(Icons.add),
                                  hasIcon: false,
                                  text: "Checkout",
                                  buttonColor: const Color(0xFF4f4d1f),
                                  sizeWidth: 80.0,
                                  onPress: () {
                                    Modular.to.pop();
                                    // Navigator.pushNamedAndRemoveUntil(
                                    //     context,
                                    //     '/Checkout',
                                    //     ModalRoute.withName('/Menu-Types'));
                                  },
                                ),
                                const SizedBox(
                                  width: 30.0,
                                ),
                                MainButton(
                                  brand: const Icon(Icons.add),
                                  hasIcon: false,
                                  text: "Buy More",
                                  buttonColor: const Color(0xFF4f4d1f),
                                  sizeWidth: 80.0,
                                  onPress: () async{
                                    await sendOrder();
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/Menu-Types',
                                        ModalRoute.withName('/Menu-Itens'));
                                  },
                                ),
                                const SizedBox(
                                  width: 10.0,
                                ),
                              ]);
                        },
                        child: Stack(
                          children: const [
                            Positioned(
                              top: 20.0,
                              left: 15.0,
                              child: SizedBox(
                                width: 70.0,
                                child: Text(
                                  "ORDER NOW",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: "KGBrokenVesselsSketch",
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0,
                                    overflow: TextOverflow.clip,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 55.0,
                              left: 20.0,
                              child: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                size: 60.0,
                                color: Colors.yellowAccent,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (!showScreen)
                    Positioned.fill(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                        child: Center(
                          child: Container(
                            width: 90.0,
                            height: 90.0,
                            padding: const EdgeInsets.all(5),
                            child: const CircularProgressIndicator(
                              strokeWidth: 5.0,
                              color: Color(0xFF4f4d1f),
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
