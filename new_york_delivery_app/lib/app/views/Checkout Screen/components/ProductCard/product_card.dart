import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ProductCard extends StatefulWidget {
  final Function() addProduct;
  final Function() minusProduct;
  final Function() deleteProduct;
  final String title;
  final String type;
  final List<dynamic> extras;
  final int quantity;
  final double price;
  final double total;
  const ProductCard(
      {Key? key,
      required this.title,
      required this.type,
      required this.extras,
      required this.quantity,
      required this.price,
      required this.total, required this.addProduct,required this.minusProduct,required this.deleteProduct})
      : super(key: key);

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200.0,
      height: 220 + (17.00 * widget.extras.length),
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Align(
              child: Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xFF4f4d1f),
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
          const SizedBox(
            height: 0.0,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20.0, bottom: 10.0, top: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Type: ",
                        style: TextStyle(
                          color: Color(0xFF4f4d1f),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.type,
                        style: const TextStyle(
                          color: Color(0xFF4f4d1f),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text(
                        "Extras: ",
                        style: TextStyle(
                          color: Color(0xFF4f4d1f),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(widget.extras.length, (index) {
                        return Row(
                          children: [
                            Text(
                              widget.extras[index]['menu_extra']['name']
                                  .toString(),
                              style: const TextStyle(
                                color: Color(0xFF4f4d1f),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 0.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Quantity: ",
                          style: TextStyle(
                            color: Color(0xFF4f4d1f),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 130.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      width: 65.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF4f4d1f),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              iconSize: 25.0,
                                              padding: const EdgeInsets.all(0),
                                              icon: const Icon(Icons.remove),
                                              color: Colors.white,
                                              onPressed: widget.minusProduct,
                                            ),
                                          ),
                                          Container(
                                            width: 25.0,
                                            height: 25.0,
                                            decoration: const BoxDecoration(
                                              color: Color(0xFF4f4d1f),
                                              shape: BoxShape.circle,
                                            ),
                                            child: IconButton(
                                              iconSize: 25.0,
                                              padding: const EdgeInsets.all(0),
                                              icon: const Icon(Icons.add),
                                              color: Colors.white,
                                              onPressed: widget.addProduct,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15.0,
                                    ),
                                    Text(
                                      "${widget.quantity}",
                                      style: const TextStyle(
                                        color: Color(0xFF4f4d1f),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Price: ",
                          style: TextStyle(
                            color: Color(0xFF4f4d1f),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        widget.price.toString().length == 3 ? "£ ${widget.price}0" : "£ ${widget.price}",
                        style: const TextStyle(
                          color: Color(0xFF4f4d1f),
                        ),
                      )
                    ],
                  ),
                  const Divider(
                    height: 5,
                    color: Color(0xFF4f4d1f),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Total:",
                          style: TextStyle(
                            color: Color(0xFF4f4d1f),
                            fontSize: 15.0,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                        widget.total.toString().length == 3 ? "£ ${ widget.total}0" : "£ ${widget.total}",
                        style: const TextStyle(
                          color: Color(0xFF4f4d1f),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 50.0,
            color: const Color(0xFF4f4d1f),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: widget.deleteProduct,
                  child: Container(
                    margin: const EdgeInsets.only(right: 15.0),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
