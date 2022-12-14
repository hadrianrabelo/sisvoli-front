import 'package:flutter/material.dart';

class BackGround extends StatefulWidget {
  const BackGround({Key? key, required this.background,}) : super(key: key);
  final Widget background;

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:<Widget>[
        Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight ,
                colors:[
                  Color.fromARGB(255, 11, 11, 11),
                  Color.fromARGB(255, 1, 1, 1)],
              )
          ),
          child: widget.background,
        ),
      ],
    );
  }
}
