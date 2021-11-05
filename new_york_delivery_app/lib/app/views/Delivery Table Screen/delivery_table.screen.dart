import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/views/Add%20Collect%20Screen/components/Form/collect_form.dart';
import 'package:new_york_delivery_app/app/views/Delivery%20Table%20Screen/components/Form/delivary_table_form.dart';

class DeliveryTableScreen extends StatefulWidget {
  final Map info;
  const DeliveryTableScreen({Key? key,required this.info}) : super(key: key);

  @override
  _DeliveryTableScreenState createState() => _DeliveryTableScreenState();
}

class _DeliveryTableScreenState extends State<DeliveryTableScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Number of Table",
          style: TextStyle(fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
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
          child: ListView(
            children: [
              Column(
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
                      children: const [
                        SizedBox(
                          height: 10.0,
                        ),
                         DeliveryTableForm(),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
