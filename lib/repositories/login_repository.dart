import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String _listApi = dotenv.get("API_HOST", fallback: "");

Future<int?> userLogin({cpf, userPassword}) async{
  try{
    var url = Uri.parse('$_listApi/login');
    var response = await http.post(url, body:{'userDocument':'$cpf', 'password':'$userPassword'});
    if(response.statusCode == 200){
      Map<String, dynamic> map = jsonDecode(response.body);
      accessToken(
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
Future accessToken({accessToken, refreshToken,userCpf}) async{
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('access_token', accessToken);
  prefs.setString('refresh_token', refreshToken);
  prefs.setString('userCpf', userCpf);
  SaveSession session = SaveSession(createAt: DateTime.now());
}
class SaveSession{
  late DateTime createAt;

  SaveSession({required this.createAt});
}