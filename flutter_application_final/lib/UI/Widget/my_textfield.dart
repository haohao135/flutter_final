import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({super.key, required this.controller, required this.labelText, required this.error});
  TextEditingController controller;
  String labelText;
  bool error;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
        errorText: error ? "Nhập chưa đủ kí tự" : null
      ),
    );
  }
}