import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../repositories/recover_pass_repository.dart';
import '../values/background.dart';
import '../values/custom_colors.dart';
import '../view-models/recover_view_model.dart';

class RecoverPassView extends StatefulWidget {
  const RecoverPassView({Key? key}) : super(key: key);

  @override
  State<RecoverPassView> createState() => _RecoverPassViewState();
  }
  class _RecoverPassViewState extends State<RecoverPassView> {
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final _getCpf = TextEditingController();
  String? setCpf;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        background: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Recuperar\na Senha',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: "Inter",
                              fontSize: 27,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery
                              .of(context)
                              .size
                              .height * 0.02,
                        ),
                        const SizedBox(
                          child: Text(
                            'Identifique-se para receber um e-mail com instruções e um link para criar uma nova senha.',
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.2,
                    ),
                    TextFormField(
                        controller: _getCpf,
                        validator: (cpf) {
                          if (RecoverViewModel().valiCpf(cpf)) {
                            return "CPF Inválido!";
                          } else {
                            return null;
                          }
                        },
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CpfInputFormatter(),
                        ],
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60)),
                          labelText: "CPF",
                          labelStyle: TextStyle(
                              color: Colors.white60, fontFamily: 'Roboto'),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.number),
                    Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.3,
                    ),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          _formKey.currentState!.validate();
                          setCpf = _getCpf.text.replaceAll(
                              RegExp('[^A-Za-z0-9]'), '');
                          recoverPass(cpf: setCpf).then((value) {
                            setState(() {
                              if (value == 200) {
                                Navigator.pushNamed(context, '/recover_code');
                              } else if (value == 409) {
                                print(value);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text('Já foi enviado um código'),
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                                print("Já foi enviado um código");
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.redAccent,
                                      content: Text(
                                          'Houve um erro, por favor tente novamente mais tarde'),
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              }
                            });
                          });
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                customColors.getPrimaryButton)),
                        child: const Text(
                          'Enviar Código',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Já possui uma conta?",
                          style: TextStyle(
                              color: Color.fromRGBO(255, 255, 255, 0.6)),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Faça Login",
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Color.fromRGBO(255, 255, 255, 0.6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}