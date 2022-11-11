import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/models/register_model.dart';
import 'package:http/http.dart' as http;

void main() {
  userRegister();
}

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

Future passwordRecover() async {
  try {var url = Uri.parse("$_listApi/user/password-recover/40230914802");
  var response = await http.patch(url);
  print(response.body);
  Map<String, dynamic> map;} catch(e) {print(e);};




}

