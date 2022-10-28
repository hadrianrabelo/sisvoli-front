
import 'package:urnavotos/models/register_model.dart';
import 'package:http/http.dart' as http;

void main() {
  userRegister();

}
  Future userRegister({name, gender, email, password, cpf, birthDate, username}) async {


    var url = Uri.parse("http://26.132.120.62:8080/user/new");
    var response = await  http.post(url, body: {
      "name": "$name",
      "gender": "$gender",
      "email": "$email",
      "password": "$password",
      "cpf": "$cpf",
      "birthDate": "$birthDate",
      "username": "$username"
    },  );
    print(response.body);

}
  Future passwordRecover() async {
    var url = Uri.parse(
        "http://26.132.120.62:8080/user/password-recover/40230914802");
    var response = await http.patch(url);
    print(response.body);
    Map<String, dynamic> map;

  }