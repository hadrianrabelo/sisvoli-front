import 'package:flutter/material.dart';
import 'package:urnavotos/values/background.dart';
import 'package:urnavotos/views/survey_view.dart';
import '../repositories/creating_poll_repository.dart';
import '../view-models/poll_user_view_model.dart';

class UserPollView extends StatefulWidget {
  final String pollId;

  const UserPollView({Key? key, required this.pollId}) : super(key: key);

  @override
  State<UserPollView> createState() => _UserPollViewState();
}

class _UserPollViewState extends State<UserPollView> {
  final PollControllerNotNull _controller = PollControllerNotNull();
  late int length = _controller.poll.value.optionList!.length;
  bool wasSelected = false;
  int selectedAnswer = -1;
  String message = "";
  int start = 0;

  @override
  void initState() {
    super.initState();
    _controller.getPollSec(pollId: widget.pollId).then((result) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          setState(() {});
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
                                Text(
                                  _controller.title!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
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
                                  enableInteractiveSelection: false,
                                  focusNode: AlwaysDisabledFocusNode(),
                                  initialValue: _controller.description,
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
                                  height: 15,
                                ),
                                Column(
                                  children: [
                                    Form(
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            itemCount: _controller.list.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Column(children: [
                                                SizedBox(
                                                  width: 345,
                                                  height: 53,
                                                  child: ElevatedButton(
                                                    onPressed: () async {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            ScaffoldMessenger(
                                                          child: Builder(
                                                            builder:
                                                                (context) =>
                                                                    Scaffold(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              body:
                                                                  GestureDetector(
                                                                behavior:
                                                                    HitTestBehavior
                                                                        .opaque,
                                                                onTap: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {},
                                                                  child: Center(
                                                                    child:
                                                                        SizedBox(
                                                                      width:
                                                                          345,
                                                                      height:
                                                                          300,
                                                                      child:
                                                                          AlertDialog(
                                                                            backgroundColor: Colors.black87,
                                                                        title:
                                                                            Text(
                                                                          "Deseja confirmar a opção: \n\n\n ${index +1}- ${_controller.poll.value.optionList![index].name}",
                                                                          style:
                                                                              const TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                        ),

                                                                            actions: [
                                                                              ElevatedButton(onPressed: () {Navigator.of(context).pop();}, style: const ButtonStyle(
                                                                                backgroundColor: MaterialStatePropertyAll(Colors.black),
                                                                              ), child: const Text('Cancelar', style: TextStyle(
                                                                                color: Colors.white,
                                                                                fontFamily: "Inter",
                                                                              ),),),
                                                                              GestureDetector(
                                                                                onTap:
                                                                                    () async {
                                                                                  await _controller.vote("${_controller.poll.value.optionList![index].id}").then((result) {
                                                                                    message = result;
                                                                                  },);

                                                                                  if(await message == "PS-0000") {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: const Text("Voto confirmado com sucesso"),
                                                                                        backgroundColor: Colors.green,
                                                                                        duration: const Duration(seconds: 1),
                                                                                        action: SnackBarAction(
                                                                                          textColor: Colors.white,
                                                                                          label: 'OK',
                                                                                          onPressed: () {

                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ).closed.whenComplete(() => Navigator.of(context).pop());
                                                                                  } else if(await message == "PS-0040") {
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: const Text("Voto já feito anteriormente"),
                                                                                        backgroundColor: Colors.red,
                                                                                        duration: const Duration(seconds: 1),
                                                                                        action: SnackBarAction(
                                                                                          textColor: Colors.white,
                                                                                          label: 'OK',
                                                                                          onPressed: () {

                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ).closed.whenComplete(() => Navigator.of(context).pop());
                                                                                  } else if (await message == "not allowed"){
                                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                                      SnackBar(
                                                                                        content: const Text("Ocorreu um erro, tente novamente mais tarde"),
                                                                                        backgroundColor: Colors.red,
                                                                                        duration: const Duration(seconds: 1),
                                                                                        action: SnackBarAction(
                                                                                          textColor: Colors.white,
                                                                                          label: 'OK',
                                                                                          onPressed: () {

                                                                                          },
                                                                                        ),
                                                                                      ),
                                                                                    ).closed.whenComplete(() => Navigator.of(context).pop());
                                                                                  }
                                                                                },
                                                                                child:
                                                                                const Text('Confirmar', style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontFamily: "Inter",
                                                                                ),),

                                                                              ),

                                                                            ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              Color.fromRGBO(
                                                                  112,
                                                                  112,
                                                                  112,
                                                                  100)),
                                                      fixedSize:
                                                          MaterialStatePropertyAll(
                                                              Size.square(double
                                                                  .infinity)),
                                                    ),
                                                    child: Text(_controller
                                                        .list[index]),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                              ]);
                                            })),
                                  ],
                                ),
                                const SizedBox(
                                  height: 50,
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
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.87,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(38, 110, 215, 1.0)),
                      ),
                      child: const Text(
                        "Voltar para enquetes",
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
