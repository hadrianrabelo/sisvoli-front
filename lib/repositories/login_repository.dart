import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

SaveSession session = SaveSession();

Future<int?> userLogin({cpf, userPassword}) async{
  try{
    var url = Uri.parse('http://54.174.200.131:8080/login');
    var response = await http.post(url, body:{'userDocument':'$cpf', 'password':'$userPassword'});
    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);
      saveToken(
        accessToken: jsonEncode(map['access_token']),
        refreshToken: jsonEncode(map['refresh_token']),
        userCpf: jsonEncode(map['userCpf'],),
      );
      return response.statusCode;
    }else{
      return response.statusCode;
    }
  } catch(e){
    print(e);
  }
}
Future saveToken({accessToken, refreshToken,userCpf}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token', accessToken);
  prefs.setString('refresh_token', refreshToken);
  prefs.setString('userCpf', userCpf);
  session.createAt = DateTime.now();
}
Future<Map<String,dynamic>> accessToken() async{
  SharedPreferences  prefs = await SharedPreferences.getInstance();
  String? access_token = jsonDecode(prefs.getString('access_token')!);
  String? refresh_token = jsonDecode(prefs.getString('refresh_token')!);
  String? user_cpf = jsonDecode(prefs.getString('userCpf')!);
  Map<String, dynamic> dataToken = {
    'access_token': access_token,
    'refresh_token': refresh_token,
    'user_cpf': user_cpf,
  };
  final DateTime currentDate = DateTime.now();
  print(currentDate);
  final DateTime? createAt = session.sessao();
  print("ai $createAt");
  const int expiresIn = 600;
  final int diff = currentDate.difference(createAt!).inSeconds;

  print("tempo de vida token: ${expiresIn - diff}");
  print("expiresin $expiresIn");

  if(expiresIn - diff >= 60){
    print(dataToken['access_token']);
    return dataToken;
  }
  await refreshToken(expiredToken: dataToken['refresh_token']);
  /*print(response.data);
  if(response.data != null){
    print('OK');
  }*/
  return dataToken;
}
Future refreshToken({expiredToken}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var url = Uri.parse('http://54.174.200.131:8080/user/refresh-token');
  var response = await http.get(url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $expiredToken',
      }
  );
  if(response.statusCode == 200){
   await prefs.remove('access_token');
   await prefs.remove('refresh_token');
   await prefs.remove('user_cpf');
    Map<String, dynamic> map = jsonDecode(response.body);
    saveToken(
      accessToken: jsonEncode(map['access_token']),
      refreshToken: jsonEncode(map['refresh_token']),
      userCpf: jsonEncode(map['userCpf'],),
    );
    print(response.body);
    return response.body;
  }
  return null;
}

class SaveSession{
  DateTime? createAt;

  SaveSession({this.createAt});

  DateTime? sessao(){
    return createAt;
  }
}