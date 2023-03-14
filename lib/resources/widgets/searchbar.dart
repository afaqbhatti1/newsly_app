import 'package:flutter/material.dart';

Widget searchTextField(TextEditingController con, BuildContext context) {
  return TextFormField(
    controller: con,
    onChanged: (v) {
      v;
    },
    cursorColor: Colors.blue,
    style: const TextStyle(
      color: Colors.blue,
      fontSize: 20,
    ),
    textInputAction: TextInputAction.search,
    decoration: const InputDecoration(
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
      hintText: 'Search by tag',
      hintStyle: TextStyle(
        color: Colors.blue,
        fontSize: 20,
      ),
    ),
  );
}
