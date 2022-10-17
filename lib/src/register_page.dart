import 'package:flutter/material.dart';
import 'package:urnavotos/src/background.dart';
import 'package:urnavotos/values/custom_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CustomColors customColors = CustomColors();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackGround(
        background: Form(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                          TextSpan(
                              text: 'ISVOLI',
                              style:
                                  TextStyle(fontFamily: 'Inter', fontSize: 30))
                        ],
                      ),
                    ),
                    Container(height: MediaQuery.of(context).size.height * .06),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_box_sharp,
                          color: Colors.white,
                        ),
                        labelText: 'Nome Completo',
                        labelStyle: TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        labelText: 'E-mail',
                        labelStyle: TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Digite seu CPF',
                        hintText: '000.000.000-00',
                        hintStyle: TextStyle(color: Colors.white),
                        labelStyle: TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        labelText: 'Senha',
                        labelStyle: TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.white,
                        ),
                        labelText: 'Confirmar Senha',
                        labelStyle: TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 48,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              customColors.getPrimaryButton),
                        ),
                        child: const Text(
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Colors.white,
                          ),
                          'Registre-se',
                        ),
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
  }
}
