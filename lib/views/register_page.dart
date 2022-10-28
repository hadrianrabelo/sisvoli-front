import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urnavotos/background.dart';
import 'package:urnavotos/values/custom_colors.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:urnavotos/view_models/register_page_model.dart';

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
  final _formKey = GlobalKey<FormState>();

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
                    TextFormField(
                      controller: _nameEC,
                      validator: (value) {


                      },
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
                      controller: _emailEC,
                      validator: (String? value) {
                        if(value == null || value.isEmpty) {
                          return "E-mail obrigatório";
                        }
                      },
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
                      controller: _cpfEC,
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return "CPF Obrigatório";
                        }
                        if(value.length < 11) {
                          return "CPF Incompleto";
                          CPFValidator() {}
                        }
                      },
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
                      controller: _passwordEC,
                        validator: (String? value) {
                          if(value == null || value.isEmpty) {
                            return "Senha Obrigatória";
                          }
                        },
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
                      controller: _confPasswordEC,
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
                                ? Icons.circle
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
                        onPressed: () {
                          var _formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (_formValid) {}
                        },
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
