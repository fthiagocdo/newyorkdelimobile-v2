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
      required this.suffixIcon, required this.validation, required this.controller,required this.isReadOnly, required this.minLines, required this.maxLines})
      : super(key: key);

  final String? Function(String?) validation;
  // final void Function(String?) onChange;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool hasSuffixIcon;
  final bool isReadOnly;
  final String label;
  final bool showContent;
  final Color cursorColor;
  final GestureDetector suffixIcon;
  final int minLines;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.newline,
      minLines: minLines,
      maxLines: maxLines,
      style: const TextStyle(color: Color(0xFF4f4d1f),),
      controller: controller,
      validator: validation,
      // onChanged: onChange,
      readOnly: isReadOnly,
      obscureText: !showContent,
      keyboardType: keyboardType,
      cursorColor: cursorColor,
      decoration: InputDecoration(
        labelText: label != ""? label: null,
        labelStyle: const TextStyle(
          color: Color(0xFF4f4d1f),
        ),
        suffixIcon: hasSuffixIcon ? suffixIcon : null,
        focusedErrorBorder:const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4f4d1f)),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF4f4d1f)),
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
