import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  //recoverPass(cpf: '62351001672');
  //recoverPass(cpf: '91769407057');
  recoverPass(cpf: '37005340000');
}

Future<int> recoverPass({cpf}) async{
    var url = Uri.parse('http://10.0.0.136:8080/user/password-recover/$cpf');
    var response = await http.patch(url);
    print(response.statusCode);
    return response.statusCode;
}
