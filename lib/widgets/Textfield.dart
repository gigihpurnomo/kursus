import 'package:flutter/material.dart';
import 'package:kursus/utility/size_adapter.dart';

Widget textFieldfill(
    {required String fieldLabel,
    required TextEditingController? textController,
    required double size,
    required String ht}) {
  return Row(
    children: [
      Text(fieldLabel),
      Text(" : "),
      SizedBox(
        width: size,
        child: TextFormField(
          controller: textController,
          decoration: InputDecoration(hintText: ht,focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent),)
          ,enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.pinkAccent),
          ),
          ),
        ),
      ),
],
);
}