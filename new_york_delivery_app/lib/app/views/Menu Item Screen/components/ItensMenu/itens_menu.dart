import 'package:flutter/material.dart';

class ItensMenu extends StatelessWidget {
  final String itemName;
  final String price;
  final Function() onTap;
  const ItensMenu(
      {Key? key,
      required this.itemName,
      required this.price,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 5,
          child: Container(
              height: itemName.length <= 16 ? 55.00 : 90.0,
              margin: const EdgeInsets.all(5.0),
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
                            padding: const EdgeInsets.only(left: 10.0),
                            child: GestureDetector(
                              child: Container(
                                width: 25.0,
                                height: 25.0,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF4f4d1f),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                ),
                                child: const Icon(
                                  Icons.add,
                                  color: Color.fromRGBO(203, 178, 154, 1),
                                ),
                              ),
                              onTap: onTap,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: itemName.length <= 16 ? 55.00 : 90.0,
                      margin: const EdgeInsets.only(left:10.0),
                      child: Center(
                        child: SizedBox(
                          width: 170.0,
                          child: Text(
                            itemName,
                            softWrap: true,
                            maxLines: 3,
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
              )
              // Center(
              //   child: ListTile(
              //     leading: GestureDetector(
              //       child: Container(
              //         width: 25.0,
              //         decoration: const BoxDecoration(
              //           color: Color(0xFF4f4d1f),
              //           borderRadius: BorderRadius.all(Radius.circular(10.0)),
              //         ),
              //         child: const Icon(
              //           Icons.add,
              //           color: Color.fromRGBO(203, 178, 154, 1),
              //         ),
              //       ),
              //       onTap: onTap,
              //     ),
              //     title: Stack(
              //       children: [
              //         SizedBox(
              //           width: double.infinity,
              //           child: Text(
              //             itemName,
              //             style: const TextStyle(
              //                 fontSize: 20.0,
              //                 color: Color(0xFF4f4d1f),
              //                 fontFamily: "KGBrokenVesselsSketch"),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            height: itemName.length <= 16 ? 55.0 : 90.0,
            margin: const EdgeInsets.only(right: 5.0),
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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(203, 178, 154, 1),
            ),
          ),
        ),
      ],
    );
  }
}
