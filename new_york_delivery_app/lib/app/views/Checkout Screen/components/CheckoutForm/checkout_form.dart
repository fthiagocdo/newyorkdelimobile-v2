import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/MainButton/main_button.dart';
import 'package:new_york_delivery_app/app/components/TextInput/text_input.dart';
import 'package:new_york_delivery_app/app/interfaces/IAPI_client.interface.dart';
import 'package:new_york_delivery_app/app/models/User.model.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/utils/get_deli_menu_types.dart';
import 'package:new_york_delivery_app/app/views/Checkout%20Screen/components/ProductCard/product_card.dart';

class CheckoutFormScreen extends StatefulWidget {
  const CheckoutFormScreen({Key? key}) : super(key: key);

  @override
  _CheckoutFormScreenState createState() => _CheckoutFormScreenState();
}

enum DeliveryOrCollect { delivery, collect }

class _CheckoutFormScreenState extends State<CheckoutFormScreen> {
  bool showScreen = true;
  IApiClient repository = Modular.get<ApiClientRepository>();
  UserModel user = Modular.get<UserModel>();
  Map data = {"data": [], "hasData": false};
  int? shopID;

  void getCheckoutData() async {
    setState(() {
      showScreen = false;
    });
    shopID = await getMenuTypesDeliObject();
    var result;
    try {
      result = await repository.getCheckout(user.id, shopID.toString());
    } catch (e) {
      print('ERRORRRRRRRR');
      print(e);
      setState(() {
        data["hasData"] = true;
        showScreen = true;
      });
    }

    data['checkoutItens'] = result.data['checkout']['checkout_items'];
    data['info'] = result.data;
    data["hasData"] = true;
    setState(() {
      showScreen = true;
    });
  }

  void increaseQuantityProduct(String checkoutItemID) async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      // result = await repository.plusItemCheckout(user.id, shopID.toString(),
      // data['checkoutItens'][index]['id'].toString());
      result = await repository.plusItemCheckout(
          user.id, shopID.toString(), checkoutItemID);
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    getCheckoutData();
  }

  void decreaseQuantityProduct(
      int quantityProduct, String checkoutItemID) async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      if (quantityProduct - 1 != 0) {
        result = await repository.minusItemCheckout(
            user.id, shopID.toString(), checkoutItemID);
      } else {
        result = await repository.deleteItemCheckout(
            user.id, shopID.toString(), checkoutItemID);
      }
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    getCheckoutData();
  }

  void deleteProduct(String checkoutItemID) async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      // result = await repository.deleteItemCheckout(user.id, shopID.toString(),
      // data['checkoutItens'][index]['id'].toString());
      result = await repository.deleteItemCheckout(
          user.id, shopID.toString(), checkoutItemID);
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    getCheckoutData();
  }

  void increaseTipAmount() async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      result = await repository.plusTipCheckout(user.id, shopID.toString());
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    getCheckoutData();
  }

  void decreaseTipAmount() async {
    setState(() {
      showScreen = false;
    });
    var result;
    try {
      result = await repository.minusTipCheckout(user.id, shopID.toString());
    } catch (e) {
      print("ERROR ON BD");
      print(e);
    }
    getCheckoutData();
  }

  @override
  void initState() {
    super.initState();
    getCheckoutData();
  }

  DeliveryOrCollect firstChoice = DeliveryOrCollect.collect;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            showScreen == true
                ? Column(
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(data["checkoutItens"].length,
                              (index) {
                            // print(data['checkoutItens'][index]);
                            // print('\n');
                            // print(snapshot.data!['data'][index]['total_price']);
                            // print(data['checkoutItens'][index]);
                            // print(data['checkoutItens'][index]
                            //       ['checkout_item_extras'].length);
                            // print(snapshot.data!['data'][index]['checkout_item_choices']);
                            // print(snapshot.data!['data'][index]['menu_item']['price']);
                            // print(snapshot.data!['data'][index]['menu_item']['name']);
                            // print(snapshot.data!['data'][index]['menu_item']['type']['name']);
                            // print('------------');                  // return Container();
                            return ProductCard(
                              // extras: List<String>.generate(
                              // data['data'][index]['extras'].length,
                              // (index2) => data['data'][index]["extras"][index2]),
                              extras: data['checkoutItens'][index]
                                  ['checkout_item_extras'],
                              // extras: [],
                              price: double.parse(data['checkoutItens'][index]
                                      ['unitary_price']
                                  .toString()),
                              quantity: int.parse(
                                  data['checkoutItens'][index]['quantity']),
                              title: data['checkoutItens'][index]['menu_item']
                                  ['name'],
                              total: double.parse(
                                  data['checkoutItens'][index]['total_price']),
                              type: data['checkoutItens'][index]['menu_item']
                                  ['type']['name'],
                              minusProduct: () {
                                decreaseQuantityProduct(
                                  int.parse(
                                      data['checkoutItens'][index]['quantity']),
                                  data['checkoutItens'][index]['id'].toString(),
                                );
                              },
                              addProduct: () {
                                increaseQuantityProduct(
                                  data['checkoutItens'][index]['id'].toString(),
                                );
                              },
                              deleteProduct: () {
                                deleteProduct(data['checkoutItens'][index]['id']
                                    .toString());
                              },
                            );
                          }),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Container(
                        height: 130.0,
                        margin: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 5.0,
                        ),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Subtotal:",
                                  style: TextStyle(
                                    color: Color(0xFF4f4d1f),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                    "£ ${data['info']['checkout']['partial_value']}",
                                    style: const TextStyle(
                                      color: Color(0xFF4f4d1f),
                                      fontSize: 15.0,
                                    ))
                              ],
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 5.0, bottom: 5.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Rider Tip: ",
                                    style: TextStyle(
                                      color: Color(0xFF4f4d1f),
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: 130.0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                width: 65.0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                      width: 25.0,
                                                      height: 25.0,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xFF4f4d1f),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: IconButton(
                                                        iconSize: 25.0,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        icon: const Icon(
                                                            Icons.remove),
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          decreaseTipAmount();
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 25.0,
                                                      height: 25.0,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color:
                                                            Color(0xFF4f4d1f),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: IconButton(
                                                        iconSize: 25.0,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(0),
                                                        icon: const Icon(
                                                            Icons.add),
                                                        color: Colors.white,
                                                        onPressed: () {
                                                          increaseTipAmount();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 15.0,
                                              ),
                                              Text(
                                                "£ ${data['info']['checkout']['rider_tip']}",
                                                style: const TextStyle(
                                                  color: Color(0xFF4f4d1f),
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 5.0),
                              child: const Divider(
                                height: 5,
                                color: Color(0xFF4f4d1f),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Total:",
                                  style: TextStyle(
                                    color: Color(0xFF4f4d1f),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  data['info']['checkout']['total_value']
                                              .toString()
                                              .length ==
                                          3
                                      ? "£ ${data['info']['checkout']['total_value']}0"
                                      : "£ ${data['info']['checkout']['total_value']}",
                                  style: const TextStyle(
                                    color: Color(0xFF4f4d1f),
                                    fontSize: 15.0,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            Column(
              children: [
                Container(
                  height: 100.0,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextInput(
                          minLines: 3,
                          maxLines: 3,
                          isReadOnly: false,
                          controller: TextEditingController(),
                          validation: (value) {
                            if (value == null || value.isEmpty) {
                              return "Field 'Message' must be filled.";
                            }
                            return null;
                          },
                          label: "",
                          hintLabel: "Something else? Tell us...",
                          keyboardType: TextInputType.visiblePassword,
                          hasSuffixIcon: false,
                          suffixIcon: GestureDetector(),
                          cursorColor: const Color(0xFF4f4d1f),
                          showContent: true,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 5.0,
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 50.0,
                        child: RadioListTile(
                          activeColor: const Color(0xFF4f4d1f),
                          title: const Text(
                            'Delivery it at my table',
                            style: TextStyle(
                              color: Color(0xFF4f4d1f),
                              fontSize: 20.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          value: DeliveryOrCollect.delivery,
                          groupValue: firstChoice,
                          onChanged: (DeliveryOrCollect? value) {
                            firstChoice = value!;
                            setState(() {});
                          },
                        ),
                      ),
                      RadioListTile(
                        activeColor: const Color(0xFF4f4d1f),
                        title: const Text(
                          'I will collect it',
                          style: TextStyle(
                            color: Color(0xFF4f4d1f),
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        controlAffinity: ListTileControlAffinity.trailing,
                        value: DeliveryOrCollect.collect,
                        groupValue: firstChoice,
                        onChanged: (DeliveryOrCollect? value) {
                          firstChoice = value!;
                          setState(() {});
                        },
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        height: 40.0,
                        child: MainButton(
                          text: "CONFIRM",
                          onPress: () {
                            if (data['checkoutItens'].length != 0) {
                              if (firstChoice == DeliveryOrCollect.collect) {
                                print("Go to collect Page");
                                Modular.to.pushNamed("/Collect",
                                    arguments: {"data": data});
                              } else {
                                print("Go to Delivery Page");
                                Modular.to.pushNamed("/Delivery-table",
                                    arguments: {"data": data});
                              }
                            }
                          },
                          buttonColor: (data['hasData'] == false ||
                                  data['checkoutItens'].length != 0)
                              ? const Color(0xFF4f4d1f)
                              : const Color.fromRGBO(203, 178, 154, 1),
                          brand: const SizedBox(),
                          hasIcon: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
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
