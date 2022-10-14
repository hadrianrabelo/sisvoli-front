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
  CustomColors customColors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      BackGround(background:
      Padding(
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
                TextField(
                  controller: _cpf,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                      labelText: "CPF", labelStyle: TextStyle(color: Colors.white60,fontFamily: 'Roboto'),
                  ),
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number
                ),
                const SizedBox(height: 20),
                const TextField(
                  style: TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                      labelText: "Senha", labelStyle: TextStyle(color: Colors.white60, fontSize: 17,fontFamily: 'Roboto'),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60))
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
                        onPressed: null,
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
    );

  }
}
