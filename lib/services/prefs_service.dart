import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/models/user_model.dart';

class PrefsService{
  void saveUser(UserModel userCpf) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("cpf", jsonEncode(userCpf.toJson()));
  }
}