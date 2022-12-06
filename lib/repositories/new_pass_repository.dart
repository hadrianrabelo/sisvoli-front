import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  newPass(cpf: '62351001672');
}
  Future<int> newPass({cpf,token,newPassword}) async {
    final contentBody = {"cpf": "$cpf", "token": "$token", "newPassword":"$newPassword"};
    var url = Uri.parse(
        'http://10.0.0.136:8080/user/password-recover/update-password');
    var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contentBody),
    );
    //final Map<String, dynamic> map = await jsonDecode(response.body);
    var status = response.statusCode;
    return status;
  }