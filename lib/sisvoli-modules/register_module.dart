import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/models/register_model.dart';
import 'package:http/http.dart' as http;

String _listApi = dotenv.get("API_HOST", fallback: "");

Future userRegister(
    {name, gender, email, password, cpf, birthDate, username}) async {
  try {
    var url = Uri.parse("$_listApi/user/new");
    var response = await http.post(
      url,
      body: {
        "name": "$name",
        "gender": "$gender",
        "email": "$email",
        "password": "$password",
        "cpf": "$cpf",
        "birthDate": "$birthDate",
        "username": "$username"
      },
    );
    print(response.body);
  } catch (e) {
    print(e);
  }
}
