import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urnavotos/repositories/creating_poll_repository.dart';
import 'package:urnavotos/values/background.dart';
import 'package:intl/intl.dart';
import '../view-models/editing_poll_page_model.dart';

class EditingPollPage extends StatefulWidget {
  final String pollId;

  const EditingPollPage({Key? key, required this.pollId}) : super(key: key);

  @override
  State<EditingPollPage> createState() => _EditingPollPageState();
}

class _EditingPollPageState extends State<EditingPollPage> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  final EditingPollController _controller = EditingPollController();
  late int length = _controller.poll.value.optionList!.length;
  late String message;
  bool notChangedOpt = false;
  List<dynamic> compareList = [];

  @override
  void initState() {
    super.initState();
    _controller.getPollSec(widget.pollId).then((result) {
      setState(() {});
    });
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
              '  Editando a enquete',
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
                                  Row(children: const [
                                    Text(
                                      " O título da enquete é:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                    ),
                                    Text(
                                      " não editável",
                                      style: TextStyle(
                                        color: Colors.white24,
                                        fontSize: 13,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ]),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  TextFormField(
                                    initialValue: _controller.poll.value.title,
                                    enableInteractiveSelection: false,
                                    focusNode: AlwaysDisabledFocusNode(),
                                    style: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    decoration: const InputDecoration(
                                      fillColor:
                                          Color.fromRGBO(255, 255, 255, 0.07),
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      disabledBorder: OutlineInputBorder(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    " Digite a descrição da enquete:",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: "Inter",
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 9,
                                  ),
                                  TextFormField(
                                    onChanged: (text) {
                                      _controller.description = text;
                                    },
                                    initialValue:
                                        _controller.poll.value.description,
                                    validator: (String? value) {
                                      if (EditingPollPageModel()
                                              .validAndLength(value) ==
                                          '1') {
                                        return "Descrição Obrigatória";
                                      } else if (EditingPollPageModel()
                                              .validAndLength(value) ==
                                          '2') {
                                        return "No mínimo 8 caracteres";
                                      }
                                      return null;
                                    },
                                    style: const TextStyle(
                                      color: Colors.white,
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
                                    maxLines: 5,
                                    minLines: 5,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const Text(
                                    " Opções de escolha:",
                                    style: TextStyle(
                                      color: Colors.white,
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
                                                  TextFormField(
                                                    initialValue:
                                                        initialValue(index),
                                                    validator: (String? value) {
                                                      if (EditingPollPageModel()
                                                          .chooseValid(value)) {
                                                        return "preenchimento obrigatório";
                                                      }
                                                      return null;
                                                    },
                                                    onChanged: (text) {
                                                      if (index >=
                                                          _controller
                                                              .list.length) {
                                                        _controller.list
                                                            .add(text);
                                                      } else {
                                                        _controller
                                                            .list[index] = text;
                                                      }
                                                    },
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
                                                ]);
                                              })),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () {
                                            if (length <= 2) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                      EditingPollPageModel()
                                                          .snackBarText(
                                                              "Mínimo de duas opções"));
                                            } else {
                                              length--;
                                              if (_controller.list.length >
                                                  length) {
                                                _controller.list.removeLast();
                                              }
                                              setState(
                                                () {},
                                              );
                                            }
                                          },
                                          style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Colors.redAccent),
                                          ),
                                          child: const Icon(Icons.remove)),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          var chooseValid = _chooseKey
                                                  .currentState
                                                  ?.validate() ??
                                              false;
                                          if (chooseValid) {
                                            length++;
                                            setState(
                                              () {},
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(EditingPollPageModel()
                                                    .snackBarText(
                                                        "Preencha as opções vazias"));
                                          }
                                        },
                                        child: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "Data de ínicio:",
                                        style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Hora de ínicio:",
                                        style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color.fromRGBO(255, 255,
                                                          255, 0.14))),
                                          onPressed: () async {
                                            /*
                                            FocusScope.of(context).unfocus();
                                            final date = await pickDate();
                                            if (date == null) return;
                                            final newDateTime = DateTime(
                                                date.year,
                                                date.month,
                                                date.day,
                                                _controller.dateTime.hour,
                                                _controller.dateTime.minute);
                                            setState(() {
                                              _controller.dateTime = newDateTime;
                                            });
                                             */
                                          },
                                          child: Text(
                                            DateFormat("dd/MM/yyyy")
                                                .format(_controller.dateTime),
                                            style: const TextStyle(
                                                color: Colors.white38),
                                          )),
                                      const SizedBox(
                                        width: 38,
                                      ),
                                      ElevatedButton(
                                        style: const ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    Color.fromRGBO(
                                                        255, 255, 255, 0.14))),
                                        onPressed: () async {
                                          FocusScope.of(context).unfocus();
                                          /*
                                            final time = await pickTime();
                                            if (time == null) return;
                                            final newDateTime = DateTime(
                                              _controller.dateTime.year,
                                              _controller.dateTime.month,
                                              _controller.dateTime.day,
                                              time.hour,
                                              time.minute,
                                            );
                                            setState(() {
                                              _controller.dateTime = newDateTime;
                                            });
                                             */
                                        },
                                        child: Text(
                                          DateFormat("HH:mm")
                                              .format(_controller.dateTime),
                                          style: const TextStyle(
                                              color: Colors.white38),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      SizedBox(
                                        width: 60,
                                      ),
                                      Text(
                                        "Data do fim:",
                                        style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 64,
                                      ),
                                      Text(
                                        "Hora do fim:",
                                        style: TextStyle(
                                          color: Colors.white38,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 60,
                                      ),
                                      ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color.fromRGBO(255, 255,
                                                          255, 0.14))),
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();

                                            /*
                                            final dateSecond =
                                                await pickDateTwo();
                                            if (dateSecond == null) return;
                                            final newDateTimeSecond = DateTime(
                                                dateSecond.year,
                                                dateSecond.month,
                                                dateSecond.day,
                                                _controller.dateTimeSecond.hour,
                                                _controller
                                                    .dateTimeSecond.minute);
                                            setState(() {
                                              _controller.dateTimeSecond =
                                                  newDateTimeSecond;
                                            });
                                             */
                                          },
                                          child: Text(
                                            DateFormat("dd/MM/yyyy").format(
                                                _controller.dateTimeSecond),
                                            style: const TextStyle(
                                                color: Colors.white38),
                                          )),
                                      const SizedBox(
                                        width: 38,
                                      ),
                                      ElevatedButton(
                                          style: const ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color.fromRGBO(255, 255,
                                                          255, 0.14))),
                                          onPressed: () async {
                                            FocusScope.of(context).unfocus();
                                            /* final timeSecond =
                                                await pickTimeTwo();
                                            if (timeSecond == null) return;
                                            final newDateTimeSecond = DateTime(
                                                _controller.dateTimeSecond.year,
                                                _controller.dateTimeSecond.month,
                                                _controller.dateTimeSecond.day,
                                                timeSecond.hour,
                                                timeSecond.minute);
                                            setState(() {
                                              _controller.dateTimeSecond =
                                                  newDateTimeSecond;
                                            });
                                             */
                                          },
                                          child: Text(
                                            DateFormat("HH:mm").format(
                                                _controller.dateTimeSecond),
                                            style: const TextStyle(
                                                color: Colors.white38),
                                          )),
                                    ],
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
                      onPressed: () async {
                        var chooseValid =
                            _chooseKey.currentState?.validate() ?? false;
                        var formValid =
                            _formKey.currentState?.validate() ?? false;
                        if (_controller.isValid) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              EditingPollPageModel()
                                  .snackBarText("Aguarde o carregamento"));
                        } else {
                          /* if (_controller.dateTime.isBefore(DateTime.now()) ||
                              _controller.dateTimeSecond
                                  .isBefore(DateTime.now())) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                EditingPollPageModel().snackBarText(
                                    "A data e hora deve ser futura"));
                          } else if (_controller.dateTime
                              .isAtSameMomentAs(_controller.dateTimeSecond)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                EditingPollPageModel().snackBarText(
                                    "As datas de inicio e fim devem ser diferentes"));
                          } */
                          if (formValid & chooseValid) {
                            print(_controller.list);
                            print(_controller.compareList);
                            List<String> difference = (_controller.compareList
                                .toSet()
                                .difference(_controller.list.toSet())
                                .toList());
                            difference.addAll(_controller.list
                                .toSet()
                                .difference(_controller.compareList.toSet())
                                .toList());
                            if (difference.isNotEmpty) {
                              await _controller.creatingOptions(
                                  _controller.list, widget.pollId);
                            } else {
                              notChangedOpt = true;
                            }

                            if (_controller.description !=
                                _controller.poll.value.description) {
                              message = await _controller.sendPollData(
                                  "${_controller.poll.value.title}",
                                  "${_controller.description}",
                                  "${_controller.poll.value.startDate}",
                                  "${_controller.poll.value.endDate}",
                                  widget.pollId);
                            } else {
                              message = "PS-0002";
                            }

                            print(message);
                            print(notChangedOpt);
                            if (await message == "PS-0002" &&
                                notChangedOpt == true) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text("sem alterações"),
                                      backgroundColor: Colors.grey,
                                    ),
                                  )
                                  .closed
                                  .whenComplete(
                                      () => Navigator.of(context).pop());
                            } else if (message == "ok" && notChangedOpt == false) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                const SnackBar(
                                  duration: Duration(seconds: 1),
                                  content: Text(
                                      "Todas as alterações foram realizadas"),
                                  backgroundColor: Colors.green,
                                ),
                              )
                                  .closed
                                  .whenComplete(
                                      () => Navigator.of(context).pop());
                            } else if ((message == "ok") &&
                                (notChangedOpt == false)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text(
                                          "Descrição alterada com sucesso"),
                                      backgroundColor: Colors.green,
                                    ),
                                  )
                                  .closed
                                  .whenComplete(
                                      () => Navigator.of(context).pop());
                            } else if ((message == "PS-0002") &&
                                (notChangedOpt == false)) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                    const SnackBar(
                                      duration: Duration(seconds: 1),
                                      content:
                                          Text("Opções alteradas com sucesso"),
                                      backgroundColor: Colors.green,
                                    ),
                                  )
                                  .closed
                                  .whenComplete(
                                      () => Navigator.of(context).pop());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("erro tente novamente"),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        }
                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(38, 110, 215, 1.0)),
                      ),
                      child: const Text(
                        "Confirmar alterações",
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

  /*
  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: _controller.dateTime,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
      );
  Future<DateTime?> pickDateTwo() => showDatePicker(
        context: context,
        initialDate: _controller.dateTimeSecond,
        firstDate: DateTime(2022),
        lastDate: DateTime(2100),
      );
  Future<TimeOfDay?> pickTime() => showTimePicker(
        context: context,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
        initialTime: TimeOfDay(
            hour: _controller.dateTime.hour, minute: _controller.dateTime.minute),
      );
  Future<TimeOfDay?> pickTimeTwo() => showTimePicker(
        context: context,
        builder: (context, child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child ?? Container(),
          );
        },
        initialTime: TimeOfDay(
            hour: _controller.dateTimeSecond.hour,
            minute: _controller.dateTimeSecond.minute),
      );
   */

  initialValue(index) {
    if (index > (_controller.poll.value.optionList!.length - 1)) {
      return null;
    } else {
      return _controller.poll.value.optionList![index].name;
    }
  }
}
