import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/models/user_model.dart';
import '../repositories/new_pass_repository.dart';
import '../repositories/recover_pass_repository.dart';
import '../values/background.dart';
import '../values/custom_colors.dart';
import '../view-models/recover_code_view_model.dart';

class NewPassView extends StatefulWidget {
  const NewPassView({Key? key}) : super(key: key);

  @override
  State<NewPassView> createState() => _NewPassViewState();
}

class _NewPassViewState extends State<NewPassView> {
  bool _isHiddenPassFirst = true;
  bool _isHiddenPassSecond = true;
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final TextEditingController _newPassController = TextEditingController();
  final TextEditingController _conPassController = TextEditingController();

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
                            'Nova Senha',
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
                            'Digite sua nova senha e confirme.',
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
                      controller: _newPassController,
                      validator: (senha) {
                        if (senha!.isEmpty) {
                          return "Por favor, digite sua senha!";
                        } else {
                          return null;
                        }
                      },
                      obscureText: _isHiddenPassFirst,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isHiddenPassFirst
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _isHiddenPassFirst = !_isHiddenPassFirst;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                        labelText: "Nova Senha",
                        labelStyle: const TextStyle(
                            color: Colors.white60, fontFamily: 'Roboto'),
                      ),
                      style: const TextStyle(color: Colors.white),
                      //keyboardType: TextInputType.name
                    ),
                    Container(height: 20),
                    TextFormField(
                      controller: _conPassController,
                      validator: (senha) {
                        if (senha!.isEmpty) {
                          return "Por favor, confirme sua senha!";
                        } else {
                          return null;
                        }
                      },
                      obscureText: _isHiddenPassSecond,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isHiddenPassSecond
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _isHiddenPassSecond = !_isHiddenPassSecond;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                        labelText: "Confirmar Nova Senha",
                        labelStyle: const TextStyle(
                            color: Colors.white60, fontFamily: 'Roboto'),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async{
                          _formKey.currentState!.validate();
                          if (_newPassController.text != _conPassController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  backgroundColor: Colors.redAccent,
                                  content: Text("As senhas precisam ser iguais!"),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }else{
                            RecoverCodeViewModel().doNewPass(_newPassController.text);
                            if(await RecoverCodeViewModel().statusNewPass() == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Senha altera com sucesso!"),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                              Navigator.pushNamed(context, "/login");
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    backgroundColor: Colors.deepPurple,
                                    content: Text("Houve um erro, por favor tente mais tarde!"),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                customColors.getPrimaryButton)),
                        child: const Text(
                          'Salvar',
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
                            Navigator.pushNamed(context, '/login');
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
