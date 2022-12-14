import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/my_app_widget.dart';

Future main(List<String> args) async {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}