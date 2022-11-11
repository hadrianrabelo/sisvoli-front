import 'dart:convert';
import 'package:http/http.dart' as http;
void main() {
  //recoverPass(cpf: '62351001672');
  recoverPass(cpf: '11103045016');
}
Future<int> recoverPass({cpf}) async{
    var url = Uri.parse('http://26.132.120.62:8080/user/password-recover/$cpf');
    var response = await http.patch(url);
    if(response.statusCode ==200){
      print(response.statusCode);
      return response.statusCode;
    }else {
      final Map<String, dynamic> map = await jsonDecode(response.body);
      print(map);
      return response.statusCode;
    }
}