import 'package:flutter/material.dart';
import 'package:urnavotos/sisvoli-modules/creating_module.dart';
import 'package:urnavotos/values/background.dart';
import 'package:intl/intl.dart';
import 'package:urnavotos/view_models/editing_poll_page_model.dart';

class PollPageUser extends StatefulWidget {
  const PollPageUser({Key? key}) : super(key: key);

  @override
  State<PollPageUser> createState() => _PullPageUserState();
}

class _PullPageUserState extends State<PollPageUser> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  final PollController _controller = PollController();
  late int length = _controller.poll.value.optionList?.length ?? 2;
  bool tela = false;

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
              '  Votar',
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
              child: tela
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
                      child: SingleChildScrollView(
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
                                    '  Nome da Enquete',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  const Text(
                                    " Descrição da enquete:",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
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
                                        color: Colors.white60,
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
                                    height: 20,
                                  ),
                                  const Text(
                                    " Opções para escolha:",
                                    style: TextStyle(
                                      color: Colors.white54,
                                      fontSize: 15,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  Column(
                                    children: [
                                      Form(
                                          key: _chooseKey,
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemCount: length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Column(children: [
                                                  ElevatedButton(onPressed: () {}, child: Text($)),


                                                  /*
                                                  TextFormField(
                                                    initialValue:
                                                        initialValue(index),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    decoration: InputDecoration(
                                                      hintText:
                                                          "Opção ${index + 1}",
                                                      hintStyle:
                                                          const TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: "Inter",
                                                        fontSize: 12,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    8.0)),
                                                      ),
                                                      disabledBorder:
                                                          const OutlineInputBorder(),
                                                      fillColor:
                                                          const Color.fromRGBO(
                                                              255,
                                                              255,
                                                              255,
                                                              0.07),
                                                      filled: true,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 12,
                                                  ),
                                                */]);
                                              })),
                                    ],
                                  ),
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
                        "Confirmar",
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

  initialValue(index) {
    if (index > ((_controller.poll.value.optionList?.length ?? 2) - 1)) {
      return null;
    } else {
      return _controller.poll.value.optionList?[index].name ?? "";
    }
  }
}
