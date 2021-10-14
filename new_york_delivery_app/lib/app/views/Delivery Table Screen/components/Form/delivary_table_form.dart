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

  void confirmNumberTable() async {
    setState(() {
      showScreen = false;
    });
    int? shopID = await getMenuTypesDeliObject();
    if (shopID != null) {
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
      print(result);
    }
  }

  void showScreenData() async {
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
      print(result.data['details_customer']['customer']['phone_number'].length);
      _nameController.text =
          result.data['details_customer']['customer']['name'];
      _phoneController.text =
          result.data['details_customer']['customer']['phone_number'];
    } else {
      return showDialogAlert(
        title: "Message",
        message:
            "Please, add your Name or phone number before order your product",
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
                Navigator.pushNamedAndRemoveUntil(
                    context, '/Profile', ModalRoute.withName('/Menu-Types'));
              },
            ),
          ),
        ],
      );
    }
  }

  @override
  void initState() {
    showScreenData();
    super.initState();
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
