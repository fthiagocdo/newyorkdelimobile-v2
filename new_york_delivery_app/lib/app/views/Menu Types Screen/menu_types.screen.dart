import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:new_york_delivery_app/app/components/Menu/menu.dart';
import 'package:new_york_delivery_app/app/repositories/API_client.repositories.dart';
import 'package:new_york_delivery_app/app/utils/get_deli_menu_types.dart';
import 'package:new_york_delivery_app/app/views/Menu%20Types%20Screen/components/MenuTypesItem/menu_types_item.dart';

class MenuTypesScreen extends StatefulWidget {
  const MenuTypesScreen({Key? key}) : super(key: key);

  @override
  _MenuTypesScreenState createState() => _MenuTypesScreenState();
}

class _MenuTypesScreenState extends State<MenuTypesScreen> {
  ApiClientRepository repository = Modular.get<ApiClientRepository>();

  Future<List?> getMenuTypesDeli() async {
    int? menuTypes = await getMenuTypesDeliObject();
    if (!menuTypes!.isNaN) {
      var result = await repository.getMenuTypes(menuTypes.toString());
      // print(jsonDecode(result.toString()));
      return jsonDecode(result.toString())['list'];
    } else {
      Modular.to.popAndPushNamed("/Choose-Deli");
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
      drawer: const Menu(),
      body: SafeArea(
        child: FutureBuilder<List?>(
          future: getMenuTypesDeli(),
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
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return MenuTypesItem(
                      title: snapshot.data![index]['name'],
                      onTap: () {
                        Modular.to.pushNamed("/Menu-Itens",
                            arguments: snapshot.data![index]['id']);
                      },
                    );
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
