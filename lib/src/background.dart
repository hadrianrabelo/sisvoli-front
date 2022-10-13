import 'package:flutter/material.dart';

class BackGround extends StatelessWidget {
  const BackGround({Key? key, required this.child,}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[
        Container(
          padding: const EdgeInsets.all(24.0),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.black,
                Colors.white54
              ],
                stops:[
                  0.5,
                  1,
                ]
            ),
          ),
        ),
      ],
    );
  }
}
