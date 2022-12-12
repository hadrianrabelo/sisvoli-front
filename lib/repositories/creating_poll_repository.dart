import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:urnavotos/models/options_model.dart';
import '../models/poll_model.dart';
import '../models/poll_result_model.dart';
import 'login_repository.dart';

String _listApi = dotenv.get("API_HOST", fallback: "");

class PollController {
  ValueNotifier<PollModel> poll = ValueNotifier<PollModel>(PollModel());
  bool isValid = true;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  List<dynamic> list = [];
  String? description;
  String? returnMessage;


  getPollSec() async {
    var url =
        Uri.parse("$_listApi/poll/list/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
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
      var token = {};
      await accessToken().then((value) {
        token = value;
      });
      var response = await http.put(url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
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
  String? returnMessage;

  getPollSec() async {
    var url =
    Uri.parse("$_listApi/poll/list/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
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
      var token = {};
      await accessToken().then((value) {
        token = value;
      });
      var response = await http.put(url,
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
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


////////////////////////////////////////////////////
class PollResultController {

  bool isValid = true;
  late PollResultModel pollResult;

  getPollSec() async {
    var url =
    Uri.parse("$_listApi/poll/indicators/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
    });

    if (response.statusCode == 200) {
      pollResult = (PollResultModel.fromJson(jsonDecode(response.body)));
      isValid = false;

      }
    if (response.statusCode != 200) {

    }
  }
}

///////////////////////CREATING PAGE/////////////////////////
class CreatingPollController {

  Future<List<String>> createPoll(title, description, startDate, endDate) async {
    Map<String, String> body = {
      "title": "$title",
      "description": "$description",
      "startDate": "$startDate",
      "endDate": "$endDate"
    };

    var url = Uri.parse("$_listApi/poll/new");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
      },
      body: jsonEncode(body),
    );

    PollModel createpoll = PollModel.fromJson(jsonDecode(response.body));

    if (response.statusCode == 201) {
      return ["PS-0000", createpoll.id!];
    } else {
      return ["not allowed"];
    }
  }

   createPollOptions(name, pollId) async {
    Map<String, dynamic> body = {
      "name": "$name",
      "pollId": "$pollId"
    };

    var url = Uri.parse("$_listApi/option/new");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
      },
      body: jsonEncode(body),
    );
  }
}

