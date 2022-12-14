import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future<int> recoverPass({cpf}) async{
    var url = Uri.parse('http://54.174.200.131:8080/user/password-recover/$cpf');
    var response = await http.patch(url);
    print(response.statusCode);
    return response.statusCode;
}
