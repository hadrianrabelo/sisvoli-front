import 'package:flutter/material.dart';
import 'package:urnavotos/background.dart';

class CreatingPage extends StatelessWidget {
  const CreatingPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            '  Criando a enquete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Inter',
            ),
          ),
          actions: [
            Icon(
              Icons.search,
              size: 38,
              color: Colors.white,
            ),
            Icon(
              Icons.menu,
              size: 38,
              color: Colors.white,
            ),
            SizedBox(
              width: 30,
            )
          ],
        ),
        body: BackGround(
            background: Form(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(24.0),
                          decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: Color.fromRGBO(255, 255, 255, 0.07),
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                decoration: InputDecoration(
                                  labelText: "Digite o titulo da enquete:",
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  border: OutlineInputBorder(),
                                  enabledBorder: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        )),
      );
}
