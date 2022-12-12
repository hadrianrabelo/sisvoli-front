import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/values/background.dart';
import 'package:intl/intl.dart';
import '../repositories/creating_poll_repository.dart';
import '../repositories/login_repository.dart';
import '../view-models/adress_page_model.dart';
import 'package:http/http.dart' as http;

class UserPollView extends StatefulWidget {
  const UserPollView({Key? key}) : super(key: key);

  @override
  State<UserPollView> createState() => _UserPollViewState();
}

class _UserPollViewState extends State<UserPollView> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  final PollController _controller = PollController();
  late int length = _controller.poll.value.optionList?.length ?? 2;
  bool tela = false;
  bool wasSelected = false;
  int selectedAnswer = -1;
  String _listApi = dotenv.get("API_HOST", fallback: "");

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
                          height: 10,
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
                                        SizedBox(
                                          width: 345,
                                          height: 53,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: const Text(
                                                          "Deseja confirmar a opção: "),
                                                      content: ElevatedButton(onPressed: () {
                                                        selectedAnswer = index;
                                                      }, child: const Text("Confirmar")),
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
                                            child:
                                            const Text("BANANA"),
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
    ),
  );

  initialValue(index) {
    if (index > ((_controller.poll.value.optionList?.length ?? 2) - 1)) {
      return null;
    } else {
      return _controller.poll.value.optionList?[index].name ?? "";
    }
  }
  Future getData() async{
    var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var url = Uri.parse('$_listApi/poll/list/my');
    var response = http.get(url, headers: {

    }
    );
  }
}