import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  recoverCode(cpf: "91769407057", token:"BWNCYD");
}

Future<String?> recoverCode({cpf,token}) async {
  final contentBody = {"cpf": "$cpf", "token": "$token"};
  try {
    //var url = Uri.parse("http://26.132.120.62:8080/user/password-recover/response");
    var url = Uri.parse("http://10.0.0.136:8080/user/password-recover/response");
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json',},
      body: jsonEncode(contentBody),
    );
   print(response.body);
   return response.body;
  } catch (e) {
    print(e);
    return e.toString();
  }
}
