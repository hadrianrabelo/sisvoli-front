import 'package:flutter/material.dart';
import 'package:urnavotos/views/creating_page.dart';
import '/views/register_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Sisvoli',
        debugShowCheckedModeBanner: false,
        home: RegisterPage(),
    );
  }
}