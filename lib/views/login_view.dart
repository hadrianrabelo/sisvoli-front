import 'package:flutter/material.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/services.dart';
import '../view-models/login_view_model.dart';
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
  bool _isHiddenPass = true;
  final _formKey = GlobalKey<FormState>();
  CustomColors customColors = CustomColors();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
                      controller: _cpfController,
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
                      controller: _passwordController,
                      validator: (password){
                        return validation.valiPassword(password) ? "Senha Inválida!" : null;
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: _isHiddenPass,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isHiddenPass
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            color: Colors.white,
                            onPressed: () {
                              setState(() {
                                _isHiddenPass = !_isHiddenPass;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                          labelText: "Senha", labelStyle: const TextStyle(color: Colors.white60, fontSize: 17,fontFamily: 'Roboto'),
                          enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white60)),
                          prefixIcon: const Icon(Icons.key, color: Colors.white,),
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
                            onPressed: ()async{
                              _formKey.currentState!.validate();
                              setCpf =_cpfController.text.replaceAll(RegExp('[^A-Za-z0-9]'), '');
                              if(await LoginViewModel().doLogin(setCpf, _passwordController.text) == 200){
                                Navigator.pushNamed(context, '/survey');
                              }else if(await LoginViewModel().doLogin(setCpf, _passwordController.text) == 403){
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(backgroundColor: Colors.redAccent,
                                      content: Text('Por favor verifique suas informações!'),
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(backgroundColor: Colors.redAccent,
                                      content: Text('Houve um erro, porfavor tente novamente mais tarde!'),
                                      behavior: SnackBarBehavior.floating,
                                    )
                                );
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
