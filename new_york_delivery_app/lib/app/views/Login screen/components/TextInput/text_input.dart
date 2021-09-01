import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TextInput extends StatelessWidget {
  const TextInput(
      {Key? key,
      required this.keyboardType,
      required this.hasSuffixIcon,
      required this.label,
      required this.showContent,
      required this.cursorColor,
      required this.suffixIcon, required this.validation, required this.onChange})
      : super(key: key);

  final String? Function(String?) validation;
  final void Function(String?) onChange;
  final TextInputType keyboardType;
  final bool hasSuffixIcon;
  final String label;
  final bool showContent;
  final Color cursorColor;
  final GestureDetector suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      onChanged: onChange,
      obscureText: !showContent,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        suffixIcon: hasSuffixIcon ? suffixIcon : null,
        focusedErrorBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.green),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );
  }
}
