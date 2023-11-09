import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validate;
  final Widget? icon;
  final bool isPassowrd;
  final bool check;
  final int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;

  CustomTextField({
    this.hintText,
    this.controller,
    this.validate,
    this.maxLines,
    this.icon,
    this.check = false,
    this.inputAction,
    this.focusNode,
    this.isPassowrd = false,
  });

  final bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      child: TextFormField(
        maxLines: maxLines ?? 1,
        focusNode: focusNode,
        textInputAction: inputAction,
        controller: controller,
        obscureText: isPassowrd == false ? false : isPassowrd,
        validator: validate,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText ?? 'hint Text...',
          suffixIcon: icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
