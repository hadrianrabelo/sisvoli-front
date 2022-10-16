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
  final _formKey = GlobalKey<FormState>();
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
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                     const Text.rich(
                       TextSpan(
                         text: 'S',
                           style: TextStyle(
                             fontFamily: 'Vermin-Vibes',
                             fontSize: 100,
                             color: Color.fromRGBO(81, 152, 255, 1.0),
                           ),
                         children: <TextSpan>[
                           TextSpan(text: 'ISVOLI',style: TextStyle(fontFamily: 'Inter',fontSize: 30))
                         ],
                       ),
                    ),
                    Container(height: MediaQuery.of(context).size.height * .15),
                    TextFormField(
                        validator: (value){
                          if(validateCPF(value!)){
                            return null;
                          }else{
                            return "CPF Inválido!";
                          }
                        },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
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
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha", labelStyle: TextStyle(color: Colors.white60, fontSize: 17,fontFamily: 'Roboto'),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
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
                                ),
                            ),
                        ),
                      ],
                    ),
                    Container(height: MediaQuery.of(context).size.height * .15),
                     SizedBox(
                        width:MediaQuery.of(context).size.width,
                        height:50,
                        child:ElevatedButton(
                            onPressed: (){
                              _formKey.currentState!.validate();
                            },
                            style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(customColors.getPrimaryButton)),
                                child: const Text('Login',style: TextStyle(color: Colors.white,fontSize: 16)))),
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
                                ),
                            ),
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
      ),
    );
  }
  bool validateCPF(String myCpf){
    if(GetUtils.isCpf(myCpf)){
      return true;
    }else{
      return false;
    }

  }
}
