import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../repositories/new_pass_repository.dart';
import '../values/background.dart';
import '../values/custom_colors.dart';

class NewPassView extends StatefulWidget {
  const NewPassView({Key? key}) : super(key: key);

  @override
  State<NewPassView> createState() => _NewPassViewState();
}

class _NewPassViewState extends State<NewPassView> {
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final _newSenha = TextEditingController();
  final _conSenha = TextEditingController();

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
                      controller: _newSenha,
                      validator: (senha) {
                        if (senha!.isEmpty) {
                          return "Por favor, digite sua senha!";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                        labelText: "Nova Senha",
                        labelStyle: TextStyle(
                            color: Colors.white60, fontFamily: 'Roboto'),
                      ),
                      style: const TextStyle(color: Colors.white),
                      //keyboardType: TextInputType.name
                    ),
                    Container(height: 20),
                    TextFormField(
                      controller: _conSenha,
                      validator: (senha) {
                        if (senha!.isEmpty) {
                          return "Por favor, confirme sua senha!";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                        labelText: "Confirmar Nova Senha",
                        labelStyle: TextStyle(
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
                        onPressed: () {
                          _formKey.currentState!.validate();
                          //newPass(cpf: , token: ,newPassword: _newSenha);
                          if (_newSenha != _conSenha) {
                            print("As senha precisam ser iguais!");
                            //pop up dizendo que a senhas presisam ser iguais
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
