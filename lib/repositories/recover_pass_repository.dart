import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
String _listApi = dotenv.get("API_HOST", fallback: "");

Future<int> recoverPass({cpf}) async{
    var url = Uri.parse('$_listApi/user/password-recover/$cpf');
    var response = await http.patch(url);
    print(response.statusCode);
    return response.statusCode;
}
