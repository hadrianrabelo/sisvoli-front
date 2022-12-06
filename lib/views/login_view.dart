import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import '/values/custom_colors.dart';
import '/view-models/validation_view_model.dart';
import '../repositories/login_repository.dart';
import '../values/background.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key,}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final  _getCpf = TextEditingController();
  final  _getPass = TextEditingController();
  ValidationViewModel validation = ValidationViewModel();
  String? setCpf;
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
              child: SizedBox(
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
                      controller: _getCpf,
                        //onChanged: loginViewModel.(value) => ,
                        validator: (cpf){
                            return validation.valiCpf(cpf) ? null : "CPF Inválido!";
                        },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            CpfInputFormatter(),
                          ],
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                            labelText: "CPF", labelStyle: TextStyle(color: Colors.white60,fontFamily: 'Roboto'),
                            prefixIcon: Icon(Icons.account_circle, color: Colors.white,),
                        ),
                        style: const TextStyle(color: Colors.white),
                        //keyboardType: TextInputType.number
                      ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _getPass,
                      validator: (password){
                        return validation.valiPassword(password) ? "Senha Inválida!" : null;
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Senha", labelStyle: TextStyle(color: Colors.white60, fontSize: 17,fontFamily: 'Roboto'),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                          prefixIcon: Icon(Icons.key, color: Colors.white,),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: (){
                             Navigator.pushNamed(context, '/recover_pass');
                            },
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
                              if(_formKey.currentState!.validate()){
                              setCpf =_getCpf.text.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                              userLogin(cpf: setCpf, userPassword: _getPass.text).then((value) {
                                setState(() {
                                  //print(value['access_token']);
                                  if(value != null){
                                    Navigator.pushNamed(context, '/survey');
                                  }else{
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(backgroundColor: Colors.redAccent,
                                          content: Text('Por favor verifique sua informações'),
                                          behavior: SnackBarBehavior.floating,
                                        )
                                    );
                                  }
                                });
                              });
                              }else{
                                print("Informações Inválidas!");
                              }
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
}
