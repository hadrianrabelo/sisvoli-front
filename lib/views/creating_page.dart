import 'package:flutter/material.dart';
import 'package:urnavotos/background.dart';

class CreatingPage extends StatefulWidget {
  const CreatingPage({Key? key}) : super(key: key);


  @override
  State<CreatingPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<CreatingPage> {
  final maxLines = 5;



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
          actions: const [
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
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(24.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Color.fromRGBO(255, 255, 255, 0.07),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              fillColor: Color.fromRGBO(255, 255, 255, 0.07),
                              filled: true,
                              labelText: "Digite o titulo da enquete:",
                              labelStyle: TextStyle(
                                color: Colors.white,
                              ),
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 135,
                            color: const Color.fromRGBO(255, 255, 255, 0.07),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.all(
                                  20),
                                labelStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                ),
                              ),
                              maxLines: maxLines,
                              minLines: 1,
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
