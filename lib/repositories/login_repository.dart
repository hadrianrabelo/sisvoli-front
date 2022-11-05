import 'dart:convert';
import 'package:http/http.dart' as http;



/*void main(){
  userLogin(cpf: '62351001672',password: '123456789');
}*/

Future userLogin({cpf, password}) async{
  var url = Uri.parse('http://26.132.120.62:8080/login');
  var response = await http.post(url, body:{'userDocument':'$cpf', 'password':'$password'});
  if(response.statusCode==200){
    final Map<String, dynamic> map = await jsonDecode(response.body);
    //myList()=> map.entries.map((e) => e.value).toList();
    return map;
  }else if(response.statusCode==403 || response.statusCode != 200){
    print(response.statusCode);
    print('Deu errado');
    return null;
  }
}
