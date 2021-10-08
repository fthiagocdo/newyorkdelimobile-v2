import 'package:flutter/material.dart';

class ItemCheckbox extends StatelessWidget {
  final String title;
  final String price;
  final bool isTrue;
  final Function(bool?)? onTap;
  const ItemCheckbox({Key? key, required this.title, required this.price,required this.isTrue,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Container(
            height: title.length <= 16 ? 55.0 : 80.0,
            margin: const EdgeInsets.only(right: 5.0, top: 5.0),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(203, 178, 154, 1),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Checkbox(
                            value: isTrue,
                            onChanged: onTap,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: title.length <= 16 ? 55.0 : 80.0,
                    child: Center(
                      child: SizedBox(
                        width: 130.0,
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20.0,
                              overflow: TextOverflow.clip,
                              color: Color(0xFF4f4d1f),
                              fontFamily: "KGBrokenVesselsSketch"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        price != ""?
        Expanded(
          flex: 2,
          child: Container(
            height: title.length <= 16 ? 55.0 : 80.0,
            margin: const EdgeInsets.only(right: 5.0, top: 5.0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                '£ $price',
                style: const TextStyle(
                    fontSize: 22.0,
                    color: Color(0xFF4f4d1f),
                    fontFamily: "KGBrokenVesselsSketch"),
              ),
            ),
            padding: const EdgeInsets.all(5),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(203, 178, 154, 1),
            ),
          ),
        ) : const SizedBox()
      ],
    );
  }
}
