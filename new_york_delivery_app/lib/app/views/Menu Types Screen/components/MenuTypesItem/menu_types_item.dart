import 'package:flutter/material.dart';

class MenuTypesItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const MenuTypesItem({Key? key, required this.title, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.all(5),
      color: const Color.fromRGBO(203, 178, 154, 1),
      child:Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 10.0,),
          GestureDetector(
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: const BoxDecoration(
              color: Color(0xFF4f4d1f),
              borderRadius: BorderRadius.all( Radius.circular(10.0))
            ),
            child: const Icon(
              Icons.add,
              color:  Color.fromRGBO(203, 178, 154, 1),
            ),
          ),
          onTap: onTap,
        ),
        const SizedBox(width: 15.0,),
        Expanded(
          child: Text(
            title,
            overflow: TextOverflow.clip,
            style: const TextStyle(
                color: Color(0xFF4f4d1f), fontFamily: "KGBrokenVesselsSketch",
                fontSize: 25.0),
          ),
        ),
        ],
      )
      // child: ListTile(
      //   leading: GestureDetector(
      //     child: Container(
      //       decoration: const BoxDecoration(
      //         color: Color(0xFF4f4d1f),
      //         borderRadius: BorderRadius.all( Radius.circular(10.0))
      //       ),
      //       child: const Icon(
      //         Icons.add,
      //         color:  Color.fromRGBO(203, 178, 154, 1),
      //       ),
      //     ),
      //     onTap: onTap,
      //   ),
      //   title: Container(
      //     padding: const EdgeInsets.only(right:10.0),
      //     child: Text(
      //       title,
      //       style: const TextStyle(
      //           color: Color(0xFF4f4d1f), fontFamily: "KGBrokenVesselsSketch",
      //           fontSize: 25.0),
      //     ),
      //   ),
      // ),
    );
  }
}
