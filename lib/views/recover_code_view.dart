import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/models/user_model.dart';
import 'package:urnavotos/repositories/recover_code_repository.dart';
import 'package:urnavotos/views/recover_pass_view.dart';
//import '/views/login_view.dart';
import '../values/background.dart';
import '../values/custom_colors.dart';
import '../view-models/recover_code_view_model.dart';

class RecoverCodeView extends StatefulWidget {
  const RecoverCodeView({Key? key}) : super(key: key);

  @override
  State<RecoverCodeView> createState() => _RecoverCodeViewState();
}

class _RecoverCodeViewState extends State<RecoverCodeView> {
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final  TextEditingController _codeController = TextEditingController();
  RecoverPassView cpf = const RecoverPassView();

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
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        const SizedBox(
                          child: Text(
                            'Digite o código recebido no seu e-mail para criar uma nova senha.',
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
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    TextFormField(
                        controller: _codeController,
                        validator: (code) {
                          return code!.isEmpty ? "Código Inválido!" : null;
                        },
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60)),
                          labelText: "Código",
                          labelStyle: TextStyle(
                              color: Colors.white60, fontFamily: 'Roboto'),
                        ),
                        style: const TextStyle(color: Colors.white),
                        keyboardType: TextInputType.text),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async{
                          _formKey.currentState!.validate();
                          RecoverCodeViewModel().doCode(_codeController.text);
                          if(await RecoverCodeViewModel().statusRecoverCode() == "true"){
                            Navigator.pushNamed(context, "/new_pass");
                          }else if(await RecoverCodeViewModel().statusRecoverCode() == "false"){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text("O código está errado!"),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text("Houve um erro, por favor tente mais tarde."),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }
                          //Navigator.pushNamed(context, '/new_pass');

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
                            /*Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginView(),
                                ),
                                (route) => false);*/
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
