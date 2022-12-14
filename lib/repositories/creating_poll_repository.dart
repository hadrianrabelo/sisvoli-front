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





class EditingPollController {
  ValueNotifier<PollModelNotNull> poll =
      ValueNotifier<PollModelNotNull>(PollModelNotNull());
  bool isValid = true;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  List<String> list = [];
  List<String> compareList = [];
  String? description;

  getPollSec(pollId) async {
    var url = Uri.parse("http://54.174.200.131:8080/poll/list/$pollId");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
    });

    if (response.statusCode == 200) {
      poll.value = (PollModelNotNull.fromJson(jsonDecode(response.body)));
      dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.startDate!);
      dateTimeSecond =
          DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.endDate!);
      description = poll.value.description;
      for (int a = 0; poll.value.optionList!.length > a; a++) {
        list.insert(a, poll.value.optionList![a].name!);
        compareList.insert(a, poll.value.optionList![a].name!);
      }

      isValid = false;
    }
    if (response.statusCode != 200) {}
  }

  Future<String> sendPollData(
      title, description, startDate, endDate, pollId) async {
      
      Map<String, dynamic> body = {
        "title": "$title",
        "description": "$description",
        "startDate": "$startDate",
        "endDate": "$endDate"
      };
      print(body.values);
      print(body.keys);
      var url = Uri.parse("http://54.174.200.131:8080/poll/put/$pollId");
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
      
      switch (response.statusCode) {
        case 204:
          return "ok";
        
        default: 
          return "error";
      }
      
      
      
      
      
  }

  Future<String> creatingOptions(List<String>optionsName, String pollId) async {
    Map<String, dynamic> body = {"optionsName": optionsName, "pollId": pollId};
    print(body);
    print(jsonEncode(body));

    var url = Uri.parse("http://54.174.200.131:8080/option/new");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.post(
      url,
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: jsonEncode(body),
    );
    print(response.body);
    return "PS-0000";
  }
}

class PollControllerNotNull {
  ValueNotifier<PollModelNotNull> poll =
      ValueNotifier<PollModelNotNull>(PollModelNotNull());
  bool isValid = true;
  DateTime dateTime = DateTime(2022, 02, 02, 12, 00);
  DateTime dateTimeSecond = DateTime(2022, 02, 02, 12, 00);
  List<dynamic> list = [];
  String? description;
  String? returnMessage;
  String? title;
  bool isNotStarted = false;

  Future getPollSec({pollId}) async {
    var url = Uri.parse("http://54.174.200.131:8080/poll/list/$pollId");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
    });
    if (response.statusCode == 200) {
      poll.value = (PollModelNotNull.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes))));
      dateTime = DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.startDate!);
      dateTimeSecond =
          DateFormat("yyyy-MM-ddThh:mm:ss").parse(poll.value.endDate!);
      description = poll.value.description;
      title = poll.value.title;
      for (int a = 0; poll.value.optionList!.length > a; a++) {
        list.insert(a, poll.value.optionList![a].name);
      }
      isValid = false;
    if(poll.value.status == "SCHEDULED") {
      isNotStarted = true;
    }
    }
    if (response.statusCode != 200) {
      return "logue novamente";
    }
  }

  Future<String> vote(optionId) async {
    var url = Uri.parse("http://54.174.200.131:8080/option/$optionId/vote");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.post(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
    });
    print(response.statusCode);
    if (response.statusCode == 201) {
      return "PS-0000";
    } else if (response.statusCode == 409) {
      return "PS-0040";
    } else {
      return "not allowed";
    }
  }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////
class PollResultController {
  bool isValid = true;
  late PollResultModel pollResult;

  getPollSec() async {
    var url = Uri.parse(
        "http://54.174.200.131:8080/poll/indicators/f9c4e7b0-a71e-405d-88a5-c4ab646e3382");
    var token = {};
    await accessToken().then((value) {
      token = value;
    });
    var response = await http.get(url, headers: {
      HttpHeaders.authorizationHeader: 'Bearer ${token['access_token']}',
    });

    if (response.statusCode == 200) {
      pollResult = (PollResultModel.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes))));
      isValid = false;
    }
    if (response.statusCode != 200) {}
  }
}

///////////////////////CREATING PAGE/////////////////////////
class CreatingPollController {
  Future<List<String>> createPoll(
      title, description, startDate, endDate) async {
    Map<String, String> body = {
      "title": "$title",
      "description": "$description",
      "startDate": "$startDate",
      "endDate": "$endDate"
    };

    var url = Uri.parse("http://54.174.200.131:8080/poll/new");
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

    PollModelCreating createpoll =
        PollModelCreating.fromJson(jsonDecode(const Utf8Decoder().convert(response.bodyBytes)));

    if (response.statusCode == 201) {
      return ["PS-0000", createpoll.id!];
    } else {
      return ["not allowed"];
    }
  }

  createPollOptions(List<String>optionsName, String pollId) async {
    Map<String, dynamic> body = {"optionsName": optionsName, "pollId": pollId};

    var url = Uri.parse("http://54.174.200.131:8080/option/new");
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
