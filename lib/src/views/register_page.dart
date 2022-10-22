import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urnavotos/src/background.dart';
import 'package:urnavotos/src/values/custom_colors.dart';
import 'package:urnavotos/src/values/text_form_widget.dart';
import 'package:brasil_fields/brasil_fields.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CustomColors customColors = CustomColors();
  bool _isHiddenPassFirst = true;
  bool _isHiddenPassSecond = true;
  bool _isSelectedIcon = false;
  bool _isSelectedIcon2 = false;

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
                      ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.01),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          child: Text(
                            'Registrar',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.034,
                        ),
                      ],
                    ),
                    const TextFormWidget(
                      keyboardType: TextInputType.name,
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
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CpfInputFormatter(),
                      ],
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
                        labelText: 'Senha',
                        labelStyle: const TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      style: const TextStyle(color: Colors.white),
                      obscureText: _isHiddenPassSecond,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_isHiddenPassSecond
                              ? Icons.visibility
                              : Icons.visibility_off),
                          color: Colors.white,
                          onPressed: () {
                            setState(() {
                              _isHiddenPassSecond = !_isHiddenPassSecond;
                            });
                          },
                        ),
                        labelText: 'Confirmar Senha',
                        labelStyle: const TextStyle(
                            color: Colors.white60,
                            fontFamily: 'Roboto',
                            fontSize: 17),
                        border: const OutlineInputBorder(),
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white60)),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        SizedBox(
                          width: 12,
                        ),
                        Text(
                          'Gênero',
                          style: TextStyle(color: Colors.white60),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isSelectedIcon = true;
                              _isSelectedIcon2 = false;
                            });
                          },
                          icon: Icon(
                            (_isSelectedIcon
                                ? Icons.circle_sharp
                                : Icons.circle_outlined),
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '\nMasculino',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _isSelectedIcon2 = true;
                              _isSelectedIcon = false;
                            });
                          },
                          icon: Icon(
                            (_isSelectedIcon2
                                ? Icons.circle_sharp
                                : Icons.circle_outlined),
                            color: Colors.white,
                          ),
                        ),
                        const Text(
                          '\nFeminino',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                    const SizedBox(
                      height: 10,
                    ),
                    const Text.rich(
                      TextSpan(
                        text: 'Já possui uma conta? ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Faça Login',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 13,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
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
