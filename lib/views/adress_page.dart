import 'package:flutter/material.dart';
import 'package:urnavotos/values/background.dart';
import '../view_models/adress_page_model.dart';

class AdressPage extends StatefulWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            '  Preencha seu endereço',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Inter',
            ),
          ),
        ),
        body: BackGround(
          background: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Color.fromRGBO(255, 255, 255, 0.07),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "País",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            hintText: "Brazil",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 17,
                              fontFamily: 'Inter',
                            ),
                          ),
                          enableInteractiveSelection: false,
                          focusNode: AlwaysDisabledFocusNode(),
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const SizedBox(height: 12,),
                        const Text(
                          "CEP",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 13,
                            fontFamily: 'Inter',
                          ),
                        ),
                        TextFormField(
                          //controller: ,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Inter',
                          ),
                          decoration: const InputDecoration(
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color.fromARGB(255, 1, 1, 1),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.87,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(38, 110, 215, 1.0)),
                    ),
                    child: const Text(
                      "Salvar Localização",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
