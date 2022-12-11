import 'package:flutter/material.dart';
import 'package:urnavotos/repositories/creating_poll_repository.dart';
import 'package:urnavotos/values/background.dart';
import 'package:intl/intl.dart';
import 'package:urnavotos/view-models/editing_poll_page_model.dart';

class PollPageUser extends StatefulWidget {
  const PollPageUser({Key? key}) : super(key: key);

  @override
  State<PollPageUser> createState() => _PullPageUserState();
}

class _PullPageUserState extends State<PollPageUser> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  final PollController _controller = PollController();

  @override
  void initState() {
    _controller.getPollSec();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
            ),
            backgroundColor: Colors.black,
            title: const Text(
              'Relatório',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Inter',
              ),
            ),
          ),
          body: BackGround(
            background: Form(
              key: _formKey,
              child: _controller.isValid
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color.fromRGBO(255, 255, 255, 0.07),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 9,
                                ),
                                const Text(
                                  ' Quantidade de votos:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " Total: ",
                                  style: TextStyle(
                                    color: Color.fromRGBO(38, 110, 215, 100),
                                    fontSize: 17,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TextFormField(
                                  enableInteractiveSelection: false,
                                  focusNode: AlwaysDisabledFocusNode(),
                                  initialValue:
                                      _controller.description ?? "null",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(141, 141, 141, 100),
                                    fontSize: 17,
                                  ),
                                  decoration: const InputDecoration(
                                    fillColor:
                                        Color.fromRGBO(255, 255, 255, 0.07),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white70,
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                  ),
                                  maxLines: 6,
                                  minLines: 6,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "OPÇÃO VENCEDORA",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(children: [
                                  TextFormField(
                                    enableInteractiveSelection: false,
                                    focusNode: AlwaysDisabledFocusNode(),
                                    initialValue: "",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(141, 141, 141, 100),
                                      fontSize: 17,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      disabledBorder: OutlineInputBorder(),
                                      fillColor:
                                          Color.fromRGBO(100, 29, 139, 30),
                                      filled: true,
                                    ),
                                  ),
                                ]),
                                const SizedBox(
                                  height: 24,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                )
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.87,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(38, 110, 215, 1.0)),
                      ),
                      child: const Text(
                        "Retornar",
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
