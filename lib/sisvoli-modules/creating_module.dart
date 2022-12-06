import 'dart:convert';
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../models/poll_model.dart';
import '../models/poll_result_model.dart';

String _listApi = dotenv.get("API_HOST", fallback: "");

class PollController {
  ValueNotifier<PollModel> poll = ValueNotifier<PollModel>(PollModel());
  bool isValid = true;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  List<dynamic> list = [];
  String? description;
  late final _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDIxMjIzMH0.vgro6isPzwxE572FFBWQZxT_--zWIwhFMMuLB143UEs";
  String? returnMessage;

  getPollSec() async {
    var url =
        Uri.parse("$_listApi/poll/list/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      poll.value = (PollModel.fromJson(jsonDecode(response.body)));
      isValid = false;
      dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.startDate!);
      dateTimeSecond =
          DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.endDate!);
      description = poll.value.description;
      for (int a = 0; poll.value.optionList!.length > a; a++) {
        list.insert(a, poll.value.optionList![a].name);
      }
    }
    if (response.statusCode != 200) {
      returnMessage = "logue novamente";
    }
  }

  //datapoll
  sendPollData(title, description, startDate, endDate) async {
    String? newTitle = poll.value.title!;
    String? newDescription = poll.value.description!;
    String? newStartTime = poll.value.startDate!;
    String? newEndDate = poll.value.endDate!;

    if (title != poll.value.title) {
      newTitle = title;
    }
    if (description != poll.value.description) {
      newDescription = description;
    }
    if (startDate != poll.value.title) {
      newStartTime = startDate;
    }
    if (endDate != poll.value.title) {
      newEndDate = endDate;
    }

    if (title == poll.value.title &&
        description == poll.value.description &&
        startDate == poll.value.startDate &&
        endDate == poll.value.endDate) {
      Map<String, dynamic> body = {
        "title": "$newTitle",
        "description": "$newDescription",
        "startDate": "$newStartTime",
        "endDate": "$newEndDate"
      };

      var url =
          Uri.parse("$_listApi/poll/put/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
      var response = await http.put(url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $_token',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(body));

      returnMessage = "enviado com sucesso";
    } else {
      returnMessage = "sem alterações";
      //TODO CONTINUAR SEM MANDAR CURL, TUDO IGUAL, SEM NECESSIDADE
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////


class VoteController {
  ValueNotifier<PollModel> poll = ValueNotifier<PollModel>(PollModel());
  bool isValid = true;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  List<dynamic> list = [];
  String? description;
  late final _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDI4MDEyOX0.MN8WtAqVqR47-7P1TLPfM8Nt6zwrcnGWkiJ_GVtg6qM";
  String? returnMessage;

  getPollSec() async {
    var url =
    Uri.parse("$_listApi/poll/list/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      poll.value = (PollModel.fromJson(jsonDecode(response.body)));
      isValid = false;
      dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.startDate!);
      dateTimeSecond =
          DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.endDate!);
      description = poll.value.description;
      for (int a = 0; poll.value.optionList!.length > a; a++) {
        list.insert(a, poll.value.optionList![a].name);
      }
    }
    if (response.statusCode != 200) {
      returnMessage = "logue novamente";
    }
  }

  //datapoll
  sendPollData(title, description, startDate, endDate) async {
    String? newTitle = poll.value.title!;
    String? newDescription = poll.value.description!;
    String? newStartTime = poll.value.startDate!;
    String? newEndDate = poll.value.endDate!;

    if (title != poll.value.title) {
      newTitle = title;
    }
    if (description != poll.value.description) {
      newDescription = description;
    }
    if (startDate != poll.value.title) {
      newStartTime = startDate;
    }
    if (endDate != poll.value.title) {
      newEndDate = endDate;
    }

    if (title == poll.value.title &&
        description == poll.value.description &&
        startDate == poll.value.startDate &&
        endDate == poll.value.endDate) {
      Map<String, dynamic> body = {
        "title": "$newTitle",
        "description": "$newDescription",
        "startDate": "$newStartTime",
        "endDate": "$newEndDate"
      };

      var url =
      Uri.parse("$_listApi/poll/put/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
      var response = await http.put(url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $_token',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
          body: jsonEncode(body));

      returnMessage = "enviado com sucesso";
    } else {
      returnMessage = "sem alterações";
      //TODO CONTINUAR SEM MANDAR CURL, TUDO IGUAL, SEM NECESSIDADE
    }
  }
}

class PollResultController {

  late final _token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxNTc0MzQwNDA5NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDI4NzE1MX0.YuXcjkLwcyUBDlZJgTG8mH00Mu9lQWSILAq0HGlPQu0";
  bool isValid = true;
  late PollResultModel pollResult;

  getPollSec() async {
    var url =
    Uri.parse("$_listApi/poll/indicators/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer $_token',
    });

    if (response.statusCode == 200) {
      pollResult = (PollResultModel.fromJson(jsonDecode(response.body)));
      isValid = false;

      }
    if (response.statusCode != 200) {

    }
  }
}


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
