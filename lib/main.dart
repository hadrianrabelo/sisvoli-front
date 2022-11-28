import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/my_app_widget.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: MyApp()));
}