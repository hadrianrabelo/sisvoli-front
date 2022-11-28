import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/my_app_widget.dart';
import 'sisvoli-modules/register_module.dart';

void main(List<String> args) async {
  await dotenv.load(fileName: ".env");
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false, home: MyApp()));
}