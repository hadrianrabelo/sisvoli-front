import 'package:flutter/material.dart';

class BackGround extends StatefulWidget {
  const BackGround({Key? key, required this.background,}) : super(key: key);
  final Widget background;

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  Color leftColor = const Color.fromARGB(255, 11, 11, 11);
  Color rigthColor = const Color.fromARGB(255, 2, 2, 2);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[
        Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight ,
                //end: Alignment.bottomCenter,
                colors:[
                  Color.fromARGB(255, 11, 11, 11),
                  //Color.fromARGB(255, 7, 7, 7),
                  Color.fromARGB(255, 1, 1, 1)],
              )
          ),
          //color: const Color.fromRGBO(0, 0, 0, 0.95),
          child: widget.background,
        ),
      ],
    );
  }
}
