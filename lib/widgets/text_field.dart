import 'package:flutter/material.dart';

Widget customTextField(validator, controller, hintText, context,
    {kebordType = TextInputType.text, obscureText = false}) {
  final inputBorder =
      OutlineInputBorder(borderSide: Divider.createBorderSide(context));
  return TextFormField(
    scrollPadding: const EdgeInsets.only(bottom: 20),
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      border: inputBorder,
      focusedBorder: inputBorder,
      enabledBorder: inputBorder,
      filled: true,
      contentPadding: const EdgeInsets.all(8),
    ),
    keyboardType: kebordType,
    obscureText: obscureText,
  );
}
