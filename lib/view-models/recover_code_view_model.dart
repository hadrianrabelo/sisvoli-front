import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/repositories/recover_code_repository.dart';
import '../models/user_model.dart';
import '../repositories/new_pass_repository.dart';

class RecoverCodeViewModel{
  void doCode(code) async{
    UserModel userToken = UserModel(token: code);
    //print(userToken);
    _saveCode(userToken);
  }
  void doNewPass(newPassword) async{
    UserModel userNewPass = UserModel(newPassword: newPassword);
    //print(userNewPass);
  }
  void _saveCode(UserModel userToken) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token',
      jsonEncode(userToken.toJson(),
      ),
    );
  }
  Future<UserModel> _getSavedCpf() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonCpf = prefs.getString('cpf');
    Map<String,dynamic> mapCpf = jsonDecode(jsonCpf!);
    UserModel cpf = UserModel.fromJson(mapCpf);
    return cpf;
  }
  Future<UserModel> _getSavedCode() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonToken = prefs.getString('token');
    Map<String,dynamic> mapToken = jsonDecode(jsonToken!);
    UserModel token = UserModel.fromJson(mapToken);
    return token;
  }
  Future<String?> statusRecoverCode() async{
    UserModel savedCpf = await _getSavedCpf();
    UserModel savedCode = await _getSavedCode();
    String? status;
    await recoverCode(cpf: savedCpf.userCpf, token: savedCode.token).then((value){
      status = value;
    });
    return status;
  }
  Future<int?> statusNewPass() async{
    UserModel savedCpf = await _getSavedCpf();
    UserModel savedCode = await _getSavedCode();
    UserModel newPassword = UserModel();
    int? status;
    await newPass(cpf: savedCpf.userCpf, token: savedCode.token, newPassword: newPassword.newPassword).then((value){
      status = value;
    });
    return status;
  }


}