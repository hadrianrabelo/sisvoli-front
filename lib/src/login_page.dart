import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import '../values/custom_colors.dart';
import 'background.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key,}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _cpf = TextEditingController();
  //final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  /*RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass){
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }*/

  CustomColors customColors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BackGround(background:
      Form(
        key: _formKey,
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50,),
                   const Text.rich(
                     TextSpan(
                       text: 'S',
                         style: TextStyle(
                           fontFamily: 'Vermin-Vibes',
                           fontSize: 100,
                           color: Color.fromRGBO(81, 152, 255, 1.0),
                           //color: Color.fromRGBO(255, 255, 255, 1.0),
                         ),
                       children: <TextSpan>[
                         TextSpan(text: 'ISVOLI',style: TextStyle(fontFamily: 'Inter',fontSize: 30))
                       ]
                     )
                  ),
                  const SizedBox(height: 130,),
                  TextFormField(
                    validator: (value){
                      if(validateCPF(value!)){
                        return null;
                      }else{
                        return "CPF Inválido!";
                      }
                    },
                    controller: _cpf,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        //focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                        labelText: "CPF", labelStyle: TextStyle(color: Colors.white60,fontFamily: 'Roboto'),
                    ),
                    style: const TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Por favor digite sua senha!";
                      }else{
                        //bool result = validatePassword(value);
                       /* if(result){
                          return null;
                        }else{
                          return "A senha precisa ter um caracter especial, um número e uma letra maiuscula";
                        }*/
                      }
                    },

                    //controller: _confirmPasswordController,
                    style: const TextStyle(color: Colors.white),
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        //focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                        labelText: "Senha", labelStyle: const TextStyle(color: Colors.white60, fontSize: 17,fontFamily: 'Roboto'),
                        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                        //errorText:_validatePassword(_confirmPasswordController.text),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: (){},
                          child: const Text(
                              "Esqueceu a senha?",
                              style: TextStyle(decoration:TextDecoration.underline, color: Color.fromRGBO(255, 255, 255, 0.6),
                              )
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 170,),
                   SizedBox(
                      width:365,
                      height:50,
                      child:ElevatedButton(
                          onPressed: (){
                            _getCpf();
                            _formKey.currentState!.validate();
                            //_validatePassword(_confirmPasswordController.text);
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(customColors.getPrimaryButton)),
                              child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 16)))),
                  const SizedBox(height: 12,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("É novo por aqui?", style: TextStyle(color: Color.fromRGBO(255, 255, 255, 0.6)),),
                      TextButton(
                          onPressed: (){},
                          child:
                          const Text(
                              "Registre-se",
                              style: TextStyle(decoration:TextDecoration.underline, color: Color.fromRGBO(255, 255, 255, 0.6)
                              )
                          )
                      ),
                    ],
                  ),
                  const SizedBox(height: 15,),
                ],
              ),
            ),
        ),
      ),
      ),
    );
  }
  void _getCpf() {
    String cpf = _cpf.text;

    if(GetUtils.isCpf(cpf)){
      print("CPF Válido!");
    }else{
      print("CPF Inválido!");
    }
  }
  bool validateCPF(String myCpf){
    String cpf = myCpf;
    if(GetUtils.isCpf(cpf)){
      return true;
    }else{
      return false;
    }

  }
  /*
  String? _validatePassword(String value){
    String value = _confirmPasswordController.text;
    if (!(value.length > 5) && value.isNotEmpty){
      print("Senha Errada");
      return "Senha precisa ter mais de 5 characters";
    }
    return null;
  }*/
}
