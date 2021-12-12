// ignore_for_file: avoid_print, prefer_typing_uninitialized_variables
import 'dart:ui';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/utils/get_deli_menu_types.dart';
import 'package:new_york_delivery_app/app/utils/show_dialog.dart';

class CollectForm extends StatefulWidget {
  const CollectForm({Key? key}) : super(key: key);

  @override
  _CollectFormState createState() => _CollectFormState();
}

class _CollectFormState extends State<CollectForm> {
  bool showScreen = true;
  bool getDataFromDB = false;
  final _formKey = GlobalKey<FormState>();
  final ApiClientRepository repository = Modular.get<ApiClientRepository>();
  final UserModel user = Modular.get<UserModel>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String originalName = "";
  String originalPhone = "";

  DateTime selectedDate = DateTime.now();

  void confirmCollect() async {
    setState(() {
      showScreen = false;
    });
    int? shopID = await getMenuTypesDeliObject();
    if (shopID != null) {
      if (getDataFromDB &&
          (originalName == _nameController.text) &&
          (originalPhone == _phoneController.text)) {
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
      // print(result.data['details_customer']['customer']['phone_number'].length);
      _nameController.text =
          result.data['details_customer']['customer']['name'];
      _phoneController.text =
          result.data['details_customer']['customer']['phone_number'];
      originalName = result.data['details_customer']['customer']['name'];
      originalPhone =
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
      _nameController.text = "";
      _phoneController.text = "";
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
                height: 10.0,
              ),
              DateTimePicker(
                cursorColor: const Color(0xFF4f4d1f),
                style: const TextStyle(color: Color(0xFF4f4d1f)),
                type: DateTimePickerType.time,

                initialValue:
                    '${selectedDate.hour}:${'${selectedDate.minute}'.length == 1 ? '0${selectedDate.minute}' : '${selectedDate.minute}'}',
                // firstDate: DateTime.now(),
                // lastDate: DateTime(2100),
                // icon: const Icon(Icons.event),
                // dateLabelText: 'Date',
                timeLabelText: "Hour",
                // validator: (date) {
                //   String hour = date!.split(":")[0];
                //   String minutes = date.split(":")[1];
                //   TimeOfDay teste = TimeOfDay(
                //       hour: int.parse(hour), minute: int.parse(minutes));
                //   final now = DateTime.now();
                //   var dt = DateTime(
                //       now.year, now.month, now.day, teste.hour, teste.minute);
                //   if (dt.compareTo(DateTime.now().add(const Duration(minutes: 5))) < 0) {
                // return "Field 'time to collect' must be filled.";
                //     return "Field 'time to collect' must be above ${DateTime.now().hour} : ${'${DateTime.now().add(const Duration(minutes: 5)).minute}'.length == 1 ?  '0${DateTime.now().add(const Duration(minutes: 5)).minute}': '${DateTime.now().add(const Duration(minutes: 5)).minute}'}";
                //   }
                //   return null;
                // },
                onChanged: (val) {
                  String hour = val.split(":")[0];
                  String minutes = val.split(":")[1];
                  TimeOfDay teste = TimeOfDay(
                      hour: int.parse(hour), minute: int.parse(minutes));
                  final now = DateTime.now();
                  var dt = DateTime(
                      now.year, now.month, now.day, teste.hour, teste.minute);
                  selectedDate = dt;
                },
                onSaved: (val) {
                  String hour = val!.split(":")[0];
                  String minutes = val.split(":")[1];

                  TimeOfDay teste = TimeOfDay(
                      hour: int.parse(hour), minute: int.parse(minutes));
                  final now = DateTime.now();
                  var dt = DateTime(
                      now.year, now.month, now.day, teste.hour, teste.minute);
                  print(dt.toIso8601String());
                  selectedDate = dt;
                },
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
                      confirmCollect();
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
