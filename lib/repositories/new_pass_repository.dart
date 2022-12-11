import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
String _listApi = dotenv.get("API_HOST", fallback: "");

  Future<int> newPass({cpf,token,newPassword}) async {
    final contentBody = {"cpf": "$cpf", "token": "$token", "newPassword":"$newPassword"};
    var url = Uri.parse(
        '$_listApi/user/password-recover/update-password');
    var response = await http.post(url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(contentBody),
    );
    //final Map<String, dynamic> map = await jsonDecode(response.body);
    var status = response.statusCode;
    return status;
  }