import 'package:flutter/material.dart';
import 'package:urnavotos/sisvoli-modules/creating_module.dart';
import 'package:urnavotos/values/background.dart';
import 'package:urnavotos/values/custom_colors.dart';
import 'package:intl/intl.dart';
import 'package:urnavotos/view_models/creating_page_model.dart';

class CreatingPage extends StatefulWidget {
  const CreatingPage({Key? key}) : super(key: key);

  @override
  State<CreatingPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<CreatingPage> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  int numberTotal = 1;
  int numberChoice = 1;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  DateTime compareDate = DateTime(2022, 02, 02, 12, 00);
  List listChooses = [null];
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

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
            '  Criando a enquete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Inter',
            ),
          ),
          actions: const [
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
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
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
                            " Digite o titulo da enquete:",
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
                            controller: _titleController,
                            validator: (String? value) {
                              if (CreatingPageModel().validAndLength(value) ==
                                  '1') {
                                return "Titulo Obrigatório";
                              } else if (CreatingPageModel()
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
                              fillColor: Color.fromRGBO(255, 255, 255, 0.07),
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
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
                            controller: _descriptionController,
                            validator: (String? value) {
                              if (CreatingPageModel().validAndLength(value) ==
                                  '1') {
                                return "Descrição Obrigatória";
                              } else if (CreatingPageModel()
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
                              fillColor: Color.fromRGBO(255, 255, 255, 0.07),
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
                                child: Wrap(
                                  direction: Axis.vertical,
                                  children: List.generate(
                                    numberChoice + 1,
                                    (index) => SizedBox(
                                      height: 68,
                                      width: MediaQuery.of(context).size.width *
                                          0.840,
                                      child: TextFormField(
                                        validator: (String? value) {
                                          if (CreatingPageModel()
                                              .chooseValid(value)) {
                                            return "preenchimento obrigatório";
                                          }
                                          return null;
                                        },
                                        onChanged: (text) {
                                          if (index >= listChooses.length) {
                                            listChooses.add(text);
                                          } else {
                                            listChooses[index] = text;
                                          }
                                        },
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: InputDecoration(
                                          hintText: "Opção ${index + 1}",
                                          hintStyle: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Inter",
                                            fontSize: 12,
                                          ),
                                          border: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8.0)),
                                          ),
                                          disabledBorder:
                                              const OutlineInputBorder(),
                                          fillColor: const Color.fromRGBO(
                                              255, 255, 255, 0.07),
                                          filled: true,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (1 >= numberChoice) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        CreatingPageModel().snackBarText(
                                            "Mínimo de duas opções"));
                                  } else {
                                    listChooses.removeLast();
                                    numberChoice--;
                                    setState(
                                      () {},
                                    );
                                  }
                                },
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      Colors.redAccent),
                                ),
                                child: const Text(
                                  "-",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  var chooseValid =
                                      _chooseKey.currentState?.validate() ??
                                          false;
                                  if (chooseValid) {
                                    numberChoice++;
                                    setState(
                                      () {},
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        CreatingPageModel().snackBarText(
                                            "Preencha as opções vazias"));
                                  }
                                },
                                child: const Text(
                                  "+",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Inter",
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
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
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 50,
                              ),
                              Text(
                                "Hora de ínicio:",
                                style: TextStyle(
                                  color: Colors.white,
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
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(255, 255, 255, 0.14))),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final date = await pickDate();
                                    if (date == null) return;

                                    final newDateTime = DateTime(
                                        date.year,
                                        date.month,
                                        date.day,
                                        dateTime.hour,
                                        dateTime.minute);

                                    setState(() {
                                      dateTime = newDateTime;
                                    });
                                  },
                                  child: Text(DateFormat("dd/MM/yyyy")
                                      .format(dateTime))),
                              const SizedBox(
                                width: 38,
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(255, 255, 255, 0.14))),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final time = await pickTime();
                                    if (time == null) return;
                                    final newDateTime = DateTime(
                                      dateTime.year,
                                      dateTime.month,
                                      dateTime.day,
                                      time.hour,
                                      time.minute,
                                    );
                                    setState(() {
                                      dateTime = newDateTime;
                                    });
                                  },
                                  child: Text(
                                      DateFormat("HH:mm").format(dateTime))),
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
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                width: 64,
                              ),
                              Text(
                                "Hora do fim:",
                                style: TextStyle(
                                  color: Colors.white,
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
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(255, 255, 255, 0.14))),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final dateSecond = await pickDate();
                                    if (dateSecond == null) return;

                                    final newDateTimeSecond = DateTime(
                                        dateSecond.year,
                                        dateSecond.month,
                                        dateSecond.day,
                                        dateTimeSecond.hour,
                                        dateTimeSecond.minute);
                                    setState(() {
                                      dateTimeSecond = newDateTimeSecond;
                                    });
                                  },
                                  child: Text(DateFormat("dd/MM/yyyy")
                                      .format(dateTimeSecond))),
                              const SizedBox(
                                width: 38,
                              ),
                              ElevatedButton(
                                  style: const ButtonStyle(
                                      backgroundColor: MaterialStatePropertyAll(
                                          Color.fromRGBO(255, 255, 255, 0.14))),
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    final timeSecond = await pickTime();

                                    if (timeSecond == null) return;

                                    final newDateTimeSecond = DateTime(
                                        dateTimeSecond.year,
                                        dateTimeSecond.month,
                                        dateTimeSecond.day,
                                        timeSecond.hour,
                                        timeSecond.minute);

                                    setState(() {
                                      dateTimeSecond = newDateTimeSecond;
                                    });
                                  },
                                  child: Text(DateFormat("HH:mm")
                                      .format(dateTimeSecond))),
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
                    onPressed: () {
                      var chooseValid =
                          _chooseKey.currentState?.validate() ?? false;
                      var formValid =
                          _formKey.currentState?.validate() ?? false;

                      if (dateTime == compareDate ||
                              dateTimeSecond == compareDate)
                           {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CreatingPageModel().snackBarText(
                                "Selecione as datas e horas corretamente"));
                      } else if (dateTime.compareTo(DateTime.now()) < 0 ||
                          dateTimeSecond.compareTo(DateTime.now()) < 0) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            CreatingPageModel().snackBarText(
                                "A data e hora selecionada é invalida"));
                      }else if (formValid & chooseValid) {
                        createPoll(_titleController, _descriptionController,
                            dateTime, dateTimeSecond);
                        if (CreatingPoll().statusCode != 200) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              CreatingPageModel().snackBarText(
                                  "Refaça o processo"));
                        }
                      } else {ScaffoldMessenger.of(context).showSnackBar(
                          CreatingPageModel().snackBarText(
                              "Preencha as opções corretamente"));}

                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(38, 110, 215, 1.0)),
                    ),
                    child: const Text(
                      "Criar",
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

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: dateTime,
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
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
      );
}
