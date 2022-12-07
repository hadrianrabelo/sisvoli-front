import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../repositories/login_repository.dart';

class LoginViewModel{
  Future<int?> doLogin(cpf, password) async{
    UserModel userModel = UserModel(userCpf: cpf, newPassword: password);
    int? status = await statusLogin(userModel);
    return status;
  }

  Future<int?> statusLogin(UserModel userModel) async{
    var status;
    await userLogin(cpf: userModel.userCpf,userPassword: userModel.newPassword).then((value){
        status = value;
    });
    return status;
  }
  Future<UserModel> getAccessToken() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonToken = prefs.getString('access_token');
    Map<String, dynamic> mapToken = jsonDecode(jsonToken!);
    UserModel token = UserModel.fromJson(mapToken);
    return token;
  }
}