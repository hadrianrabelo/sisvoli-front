import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CreatingPoll {
  var statusCode = 0;
}


String _listApi = dotenv.get("API_HOST", fallback: "");

Future createPoll(title, description, startDate, endDate) async {
  Map<String, String> body = {
    "title": "$title",
    "description": "$description",
    "startDate": "$startDate",
    "endDate": "$endDate"
  };

  var url = Uri.parse("$_listApi/poll/new");
  var token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDI5MDI5M30.J0A52DfFvXkFeyiNidbIEGgVAIMb6eGd8QSBY3BCLk0';
  var response = await http.post(
    url,
    headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $token',
    },
    body: jsonEncode(body),
  );
  print(response.body);
  print(response.statusCode);
  if(response.statusCode == 200) {
    CreatingPoll().statusCode = response.statusCode;
  } else if (response.statusCode != 200) {
    CreatingPoll().statusCode = response.statusCode;
  }
}
