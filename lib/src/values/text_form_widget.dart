import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
    final dynamic keyboardType;
   const TextFormWidget({
    required this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.white),
      keyboardType: keyboardType,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          Icons.account_box_sharp,
          color: Colors.white,
        ),
        labelText: 'Nome Completo',
        labelStyle: TextStyle(
            color: Colors.white60,
            fontFamily: 'Roboto',
            fontSize: 17),
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white60)),
      ),
    );
  }
}