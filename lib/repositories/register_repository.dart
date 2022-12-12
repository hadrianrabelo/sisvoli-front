import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

String _listApi = dotenv.get("API_HOST", fallback: "");

class UserRegister {

  Future<String> userRegister(
      name, gender, email, password, cpf, birthDate, username) async {
    Map<String, String> body = {
      "name": "$name",
      "gender": "$gender",
      "email": "$email",
      "password": "$password",
      "cpf": "$cpf",
      "birthDate": "$birthDate",
      "username": "$username"
    };

    var url = Uri.parse("$_listApi/user/new");
    var response = await http.post(
      url,
      headers: {HttpHeaders.contentTypeHeader: 'application/json'},
      body: jsonEncode(body),
    );
    if (response.statusCode == 201) {
      return "PS-0000";
    }
    if (response.statusCode == 400) {
      return "PS-0016";
    } else {
      return "not allowed";
    }
  }
}
