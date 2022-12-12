import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:urnavotos/values/background.dart';
import 'package:urnavotos/repositories/register_repository.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:urnavotos/view-models/register_page_model.dart';
import 'package:intl/intl.dart';
import '../values/custom_colors.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  CustomColors customColors = CustomColors();
  bool _isHiddenPassFirst = true;
  bool _isHiddenPassSecond = true;
  final _formKey = GlobalKey<FormState>();
  String sex = "";
  String _comparePassword = "";
  String _password = "";
  late String _date;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mailController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BackGround(
          background: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {});
                              },
                              icon: const Icon(
                                  Icons.arrow_back_ios_new_outlined,
                                  color: Colors.white),
                            ),
                            const Text(
                              'Registrar',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                          width: MediaQuery.of(context).size.width,
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            return RegisterPageModel().validName(value);
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
                          controller: _usernameController,
                          validator: (value) {
                            return RegisterPageModel().validUser(value);
                          },
                          style: const TextStyle(color: Colors.white),
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.account_box_sharp,
                              color: Colors.white,
                            ),
                            labelText: 'Nome de Usuário',
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
                          enableInteractiveSelection: false,
                          focusNode: AlwaysDisabledFocusNode(),
                          validator: (value) {
                            return RegisterPageModel().validDate(value);
                          },
                          controller: _dateController,
                          decoration: const InputDecoration(
                            labelText: "Data de Nascimento",
                            labelStyle: TextStyle(
                              color: Colors.white60,
                            ),
                            border: OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white60)),
                            prefixIcon: Icon(
                              Icons.calendar_month_outlined,
                              color: Colors.white,
                            ),
                            hintText: "Data de Nascimento",
                            hintStyle: TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Roboto',
                              fontSize: 17,
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            DateTime? pickeddate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1920),
                                lastDate: DateTime.now());
                            if (pickeddate != null) {
                              setState(() {
                                _dateController.text =
                                    DateFormat('dd/MM/yyyy').format(pickeddate);
                                _date =
                                    DateFormat('yyyy-MM-dd').format(pickeddate);
                              });
                            }
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _mailController,
                          validator: (String? value) {
                            return (RegisterPageModel().validMailReturn(value));
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
                          controller: _cpfController,
                          validator: (value) {
                            if (CPFValidator.isValid(value)) {
                              null;
                            } else {
                              return "CPF Invalido";
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
                          validator: (String? value) {
                            return RegisterPageModel().validPassword(value,
                                secondPass: _comparePassword);
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
                          onChanged: (text) {
                            setState(() {
                              _password = text;
                            });
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            return RegisterPageModel()
                                .validPassword(value, secondPass: _password);
                          },
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
                          onChanged: (text) {
                            setState(() {
                              _comparePassword = text;
                            });
                          },
                        ),
                      ],
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
                          height: 26,
                        ),
                        Text(
                          'Gênero',
                          style: TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Inter',
                              fontSize: 14),
                        ),
                      ],
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width * 0.110,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue),
                                value: 'FEMALE',
                                groupValue: sex,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      sex = value;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 110,
                            child: Text(
                              "Feminino",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                          SizedBox(
                            height: 30.0,
                            width: MediaQuery.of(context).size.width * 0.110,
                            child: Transform.scale(
                              scale: 1.2,
                              child: Radio(
                                fillColor: MaterialStateColor.resolveWith(
                                    (states) => Colors.blue),
                                value: 'MALE',
                                groupValue: sex,
                                onChanged: (String? value) {
                                  setState(() {
                                    if (value != null) {
                                      sex = value;
                                    }
                                  });
                                },
                              ),
                            ),
                          ),
                          const SizedBox(
                            child: Text(
                              "Masculino",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontFamily: 'Inter'),
                            ),
                          ),
                        ]),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width * 0.87,
                      child: ElevatedButton(
                        onPressed: () async {
                          var formValid =
                              _formKey.currentState?.validate() ?? false;
                          if (RegisterPageModel().selectedIcon(sex)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                RegisterPageModel().snackBarGender);
                          } else if (formValid) {
                            try {
                              String message = await UserRegister()
                                  .userRegister(
                                      _nameController.text,
                                      sex,
                                      _mailController.text,
                                      _password,
                                      _cpfController.text,
                                      _date,
                                      _usernameController.text);

                                if (await message == "PS-0000") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      RegisterPageModel().snackBarSucess);
                                  Navigator.pushNamed(context, '/login');
                                } else if (message == "PS-0016") {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      RegisterPageModel().snackBarDeny);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      RegisterPageModel().snackBarNotWaited);
                                }

                            } catch (_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  RegisterPageModel().snackBarNotWaited);
                                  Navigator.pop;
                            }
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              customColors.getConfirmButton),
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
                            Navigator.pop(context);
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
