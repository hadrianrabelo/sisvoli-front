import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  userLogin(cpf: '91769407057',userPassword: '12345');
}

String _listApi = dotenv.get("API_HOST", fallback: "");

Future<int?> userLogin({cpf, userPassword}) async{
  try{
    var url = Uri.parse('$_listApi/login');
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