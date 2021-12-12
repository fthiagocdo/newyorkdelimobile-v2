// ignore_for_file: avoid_print

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/utils/get_deli_menu_types.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';

class DeliveryTableForm extends StatefulWidget {
  const DeliveryTableForm({Key? key}) : super(key: key);

  @override
  _DeliveryTableFormState createState() => _DeliveryTableFormState();
}

class _DeliveryTableFormState extends State<DeliveryTableForm> {
  final _formKey = GlobalKey<FormState>();
  final ApiClientRepository repository = Modular.get<ApiClientRepository>();
  final UserModel user = Modular.get<UserModel>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _tableNumberController = TextEditingController();
  bool showScreen = true;
  bool getDataFromDB = false;
  String originalName = "";
  String originalNumber = "";

  void confirmNumberTable() async {
    setState(() {
      showScreen = false;
    });
    int? shopID = await getMenuTypesDeliObject();
    if (shopID != null) {
      if (getDataFromDB &&
          (originalName == _nameController.text) &&
          (originalNumber == _phoneController.text)) {
        var result;
        try {
          result =
              await repository.confirmCheckout(user.id, shopID.toString(), []);
        } catch (e) {
          print('Error on BD:');
          print(e);
          setState(() {
            showScreen = true;
          });
          return showDialogAlert(
            title: "Message",
            message: "Sorry, We've got an Error, please try later",
            context: context,
            actions: [
              Center(
                child: MainButton(
                  brand: const Icon(Icons.add),
                  hasIcon: false,
                  text: "OK",
                  buttonColor: const Color(0xFF4f4d1f),
                  sizeWidth: 100.0,
                  onPress: () {
                    Modular.to.pop();
                  },
                ),
              ),
            ],
          );
        }

        setState(() {
          showScreen = true;
        });
        return showDialogAlert(
          title: "Message",
          message: "We receive your order",
          context: context,
          actions: [
            Center(
              child: MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "OK",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 100.0,
                onPress: () {
                  Modular.to.pushNamedAndRemoveUntil('/Menu-Types',
                      ModalRoute.withName('/Menu-Choice-Extras'));
                },
              ),
            ),
          ],
        );
      } else {
        setState(() {
          showScreen = true;
        });
        return showDialogAlert(
          title: "Message",
          message: "Save your details for next time?",
          context: context,
          actions: [
            Center(
              child: MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "YES",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 80.0,
                onPress: () async {
                  var teste;
                  var userInfo;
                  try {
                    try {
                      userInfo = await repository.getUser(
                          user.provider, user.providerId);
                    } catch (e) {
                      throw Exception(e);
                    }

                    try {
                      teste = await repository.updateUser(
                        user.id,
                        _nameController.text,
                        _phoneController.text,
                        userInfo.data['details_customer']['customer']
                            ['postcode'],
                        userInfo.data['details_customer']['customer']
                            ['address'],
                        userInfo.data['details_customer']['customer']
                            ['receive_notifications'],
                        user.provider,
                      );
                      if (teste.data['error']) {
                        throw Exception(teste.data['message']);
                      }
                    } catch (e) {
                      print(e);
                      throw Exception('Error updating the user info');
                    }

                    try {
                      await repository
                          .confirmCheckout(user.id, shopID.toString(), []);
                    } catch (e) {
                      throw Exception('Erro confirming the checkout');
                    }
                  } catch (e) {
                    print('Error on BD');
                    print(e);
                    setState(() {
                      showScreen = true;
                    });
                    return showDialogAlert(
                      title: "Message",
                      message: "We had a error, please try it again later ",
                      context: context,
                      actions: [
                        Center(
                          child: MainButton(
                            brand: const Icon(Icons.add),
                            hasIcon: false,
                            text: "OK",
                            buttonColor: const Color(0xFF4f4d1f),
                            sizeWidth: 100.0,
                            onPress: () {
                              Modular.to
                                ..pop()
                                ..pop()
                                ..pop();
                            },
                          ),
                        ),
                      ],
                    );
                  }
                  // Modular.to.pop();
                  return showDialogAlert(
                    title: "Message",
                    message: "We receive your order",
                    context: context,
                    actions: [
                      Center(
                        child: MainButton(
                          brand: const Icon(Icons.add),
                          hasIcon: false,
                          text: "OK",
                          buttonColor: const Color(0xFF4f4d1f),
                          sizeWidth: 100.0,
                          onPress: () {
                            Modular.to.pushNamedAndRemoveUntil('/Menu-Types',
                                ModalRoute.withName('/Menu-Choice-Extras'));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            Center(
              child: MainButton(
                brand: const Icon(Icons.add),
                hasIcon: false,
                text: "NO",
                buttonColor: const Color(0xFF4f4d1f),
                sizeWidth: 80.0,
                onPress: () async {
                  try {
                    await repository
                        .confirmCheckout(user.id, shopID.toString(), []);
                  } catch (e) {
                    print("Error on BD");
                    print(e);
                  }
                  // Modular.to.pop();
                  return showDialogAlert(
                    title: "Message",
                    message: "We receive your order",
                    context: context,
                    actions: [
                      Center(
                        child: MainButton(
                          brand: const Icon(Icons.add),
                          hasIcon: false,
                          text: "OK",
                          buttonColor: const Color(0xFF4f4d1f),
                          sizeWidth: 100.0,
                          onPress: () {
                            Modular.to.pushNamedAndRemoveUntil('/Menu-Types',
                                ModalRoute.withName('/Menu-Choice-Extras'));
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      }
    }
  }

  void showScreenData() async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      result = await repository.getUser(
          user.provider.toString(), user.providerId.toString());
    } catch (e) {
      print(e);
    }

    if (result.data['details_customer']['customer']['name'] != null &&
        (result.data['details_customer']['customer']['phone_number'] != null &&
            result.data['details_customer']['customer']['phone_number'].length >
                0)) {
      getDataFromDB = true;
      _nameController.text =
          result.data['details_customer']['customer']['name'];
      _phoneController.text =
          result.data['details_customer']['customer']['phone_number'];
      originalName = result.data['details_customer']['customer']['name'];
      originalNumber =
          result.data['details_customer']['customer']['phone_number'];
      setState(() {
        showScreen = true;
      });
    } else if (result.data['details_customer']['customer']['name'] != null ||
        (result.data['details_customer']['customer']['phone_number'] != null &&
            result.data['details_customer']['customer']['phone_number'].length >
                0)) {
      _nameController.text =
          result.data['details_customer']['customer']['name'];
      _phoneController.text =
          result.data['details_customer']['customer']['phone_number'];
      setState(() {
        showScreen = true;
      });
    } else {
      setState(() {
        showScreen = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    showScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: _nameController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'name' must be filled.";
                  }
                  return null;
                },
                label: "Name",
                keyboardType: TextInputType.emailAddress,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: _tableNumberController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'table number' must be filled.";
                  }
                  return null;
                },
                label: "Please inform the number of your table",
                keyboardType: TextInputType.number,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextInput(
                minLines: 1,
                maxLines: 1,
                isReadOnly: false,
                controller: _phoneController,
                validation: (value) {
                  if (value == null || value.isEmpty) {
                    return "Field 'Phone Number' must be filled.";
                  }
                  return null;
                },
                label: "Phone Number",
                keyboardType: TextInputType.phone,
                hasSuffixIcon: false,
                suffixIcon: GestureDetector(),
                cursorColor: const Color(0xFF4f4d1f),
                showContent: true,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Center(
                child: MainButton(
                  brand: const Icon(Icons.add),
                  hasIcon: false,
                  sizeWidth: 150,
                  text: "CONFIRM",
                  buttonColor: const Color(0xFF4f4d1f),
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      confirmNumberTable();
                    }
                  },
                ),
              )
            ],
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
    );
  }
}
