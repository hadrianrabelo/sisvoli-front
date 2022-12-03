import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/poll_model.dart';

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
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDAyMTA5MX0.9vqpEBzMxKqWkvPVytkHsQGBGO5OeVlEKuwcf5Q2A-k';
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


Future getPoll () async{
  var url = Uri.parse("$_listApi/poll/new");
  var token =
      'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDAzMzM1M30.GtWmo8lLEJtI6BiZfUZonId6QeUM3aLqws4ex_q0FmA';
  var response = await http.get(url, headers: {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer $token',
  }
  );
  if(response.statusCode == 200) {
    PollModel poll = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    print(poll.optionList);
  } else {
    print("nothing");
      throw Exception('Não foi possivel carregar as informações da enquete');
  }
}