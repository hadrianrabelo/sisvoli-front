import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  userLogin(cpf: '91769407057',userPassword: '12345');
}

Future<int?> userLogin({cpf, userPassword}) async{
  try{
    var url = Uri.parse('http://10.0.0.136:8080/login');
    var response = await http.post(url, body:{'userDocument':'$cpf', 'password':'$userPassword'});
    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', jsonEncode(map['access_token'],),);
      prefs.setString('refresh_token', jsonEncode(map['refresh_token']),);
      prefs.setString('userCpf', jsonEncode(map['userCpf'],),);
      return response.statusCode;
    }else{
      return response.statusCode;
    }
  } catch(e){
    print(e);
  }
}