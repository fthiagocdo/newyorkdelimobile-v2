import 'package:flutter/material.dart';
import 'package:new_york_delivery_app/app/views/Add%20Collect%20Screen/components/Form/collect_form.dart';

class AddCollectScreen extends StatefulWidget {
  const AddCollectScreen({Key? key}) : super(key: key);

  @override
  _AddCollectScreenState createState() => _AddCollectScreenState();
}

class _AddCollectScreenState extends State<AddCollectScreen> {

  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Confirm your phone",
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
                         CollectForm(),
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
