import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/models/profile_model.dart';
import 'package:urnavotos/values/background.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../repositories/login_repository.dart';
import 'login_view.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  State<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<EditProfileView> {
  String _listApi = dotenv.get("API_HOST", fallback: "");
  bool _isHiddenPassFirst = true;
  bool _isHiddenPassSecond = true;
  final _formKey = GlobalKey<FormState>();
  String _comparePassword = "";
  String _password = "";
  bool isLoading = true;
  final Map<String, dynamic> _userData = {};
  late String sexo = _userData['gender'];
  //SnackBar snackBar = RegisterPageModel().snackBar;
  late final nameController = TextEditingController(text: _userData['name']);
  late final TextEditingController mailController = TextEditingController(text: _userData['email']);
  final TextEditingController passController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  late DateTime birthDate = _userData['birthDate'];
  late String date = DateFormat("dd-MM-yyyy").format(birthDate);
  late final TextEditingController _dateController = TextEditingController(text: _userData['birthDate']);

  @override
  void initState() {
    super.initState();
    getUser();
  }


  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      //centerTitle: true,
      //title: Text("Editar Perfil", style: TextStyle(fontFamily: "Inter"),),
      backgroundColor: Color.fromARGB(255, 1, 1, 1),
      leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white),
      ),
    ),
    //drawer: const LoginView(),
    body: BackGround(
      background: Form(
        key: _formKey,
        child: isLoading
            ? Center(child: CircularProgressIndicator(),)
        : ListView(
          padding: const EdgeInsets.all(22.0),
          children: [SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  child: Text(
                    "Editar Perfil",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Inter",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                      width: MediaQuery.of(context).size.width,
                    ),

                    TextFormField(
                      controller: nameController,
                      //initialValue: _userData['name'],
                      validator: (value) {
                        //return RegisterPageModel().validName(value);
                      },
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.account_circle,
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
                      enableInteractiveSelection: false,
                      focusNode: AlwaysDisabledFocusNode(),
                      validator: (value) {
                        //return RegisterPageModel().validDate(value);
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
                          Icons.calendar_today_rounded,
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
                            birthDate = pickeddate;
                            _dateController.text =
                                DateFormat('dd-MM-yyyy').format(pickeddate);
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: mailController,
                      //initialValue: _userData['email'],
                      validator: (String? value) {
                       // return (RegisterPageModel().validMailReturn(value));
                      },
                      style: const TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.alternate_email_outlined,
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
                      validator: (String? value) {
                        //return RegisterPageModel().validPassword(value,
                         //   secondPass: _comparePassword);
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: _isHiddenPassFirst,
                      decoration: InputDecoration(
                        prefixIcon:const Icon(Icons.lock, color: Colors.white,),
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
                      //  return RegisterPageModel()
                         //   .validPassword(value, secondPass: _password);
                      },
                      style: const TextStyle(color: Colors.white),
                      obscureText: _isHiddenPassSecond,
                      decoration: InputDecoration(
                        prefixIcon:const Icon(Icons.lock, color: Colors.white,),
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                /*Row(
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
                ),*/
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
                            groupValue: sexo,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  sexo = value;
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
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                          ),
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
                            groupValue: sexo,
                            onChanged: (String? value) {
                              setState(() {
                                if (value != null) {
                                  sexo = value;
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
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ]),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                SizedBox(
                  height: 48,
                  width: MediaQuery.of(context).size.width * 0.87,
                  child: ElevatedButton(
                    onPressed: () {
                      //String dateBirth = DateFormat("yyyy-MM-dd").format(birthDate);
                      editUser(
                          name: nameController.text,
                          gender: sexo,
                          email: mailController.text,
                          password: _comparePassword,
                          birthDate: _dateController.text
                      ).then((value) {
                        setState(() {
                          if(value == 200){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(backgroundColor: Colors.green,
                                  content: Text('Informações salvas com sucesso!'),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }else if(value == 404){
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(backgroundColor: Colors.redAccent,
                                  content: Text('Houve um erro, verifique suas informações!'),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(backgroundColor: Colors.redAccent,
                                  content: Text('Houve um erro, por favor tente mais tarde!'),
                                  behavior: SnackBarBehavior.floating,
                                )
                            );
                          }
                        });
                      });
                      print("data: ${_dateController.text}");
                      /*var formValid =
                          _formKey.currentState?.validate() ?? false;
                      if (RegisterPageModel().selectedIcon(sexo)) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar);
                      } else if (formValid) {
                        print("tudo certo");
                      }*/
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(38, 110, 215, 1.0)),
                    ),
                    child: const Text(
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      'Salvar',
                    ),
                  ),
                ),
              ],
            ),
          ),]
        ),
      ),
    ),
  );
  Future<void> getUser() async{
    var url = Uri.parse("$_listApi/user/user-data");
    var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var response = await http.get(url,
        headers:
        {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
        });
    if(response.statusCode == 200){
      //print("Deu Certo");
      //print(response.body);
      //List listSurvey = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));


      setState(() {
        Map<String, dynamic> listData = jsonDecode(response.body);
        print(listData);
        //listData.map((json) => ProfileModel.fromJson(json)).toList();
        isLoading = false;
        //_userData.addAll(listData);
        _userData.addAll(listData);
      });
    }
  }
  Future<int> editUser({name,gender,email,password,birthDate}) async{
    var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });
    Map<String, String> bodyContent = {
      "name": name,
      "gender": gender,
      "email":email,
      "password": password,
      "birthDate": '$birthDate'
    };
    if(bodyContent["name"]!.isEmpty){
      print("name: ${bodyContent["name"]}");
      bodyContent.remove("name");
    }
    if(bodyContent["gender"]!.isEmpty){
      print("gender: ${bodyContent["gender"]}");
      bodyContent.remove("gender");
    }
    if(bodyContent["email"]!.isEmpty){
      print("email: ${bodyContent["email"]}");
      bodyContent.remove("email");
    }
    if(bodyContent["password"]!.isEmpty){
      print("Senha: ${bodyContent["password"]}");
      bodyContent.remove("password");
    }
    if(bodyContent["birthDate"]!.isEmpty){
      print("birthDate: ${bodyContent["birthDate"]}");
      bodyContent.remove("birthDate");
    }
    /*bodyContent.forEach((key, value) =>{
      if(value.isEmpty){
        print("$key:$value"),
        bodyContent.remove(key),
      }
    });*/
    print(jsonEncode(bodyContent));
    var url = Uri.parse("$_listApi/user/update");
    var response = await http.put(
      url,
      headers:{
        HttpHeaders.contentTypeHeader:'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
      },
      body: jsonEncode(bodyContent),
    );
    print(jsonEncode(bodyContent));
    print(response.statusCode);
    return response.statusCode;
  }
}
class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}