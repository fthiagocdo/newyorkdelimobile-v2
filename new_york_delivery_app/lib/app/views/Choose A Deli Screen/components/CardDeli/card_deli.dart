import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardDeli extends StatelessWidget {
  final Function() onTap;
  final String deliName;
  final String address;
  final int deliID;
  const CardDeli({Key? key, required this.deliName, required this.address, required this.onTap, required this.deliID})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      padding: const EdgeInsets.all(10),
      color: const Color.fromRGBO(203, 178, 154, 1),
      child: ListTile(
        onTap: onTap,
        isThreeLine: true,
        contentPadding: const EdgeInsets.all(5),
        title: Padding(
          padding: const EdgeInsets.only(bottom:10.0),
          child: Text(
            deliName,
            style: const TextStyle(
                color: Color(0xFF4f4d1f), fontFamily: "KGBrokenVesselsSketch"),
          ),
        ),
        subtitle: Text(
          address,
          style: const TextStyle(
              color: Color(0xFF4f4d1f), fontFamily: "KGBrokenVesselsSketch"),
        ),
      ),
    );
  }
}
