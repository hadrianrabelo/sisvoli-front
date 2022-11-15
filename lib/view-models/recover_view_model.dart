import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/models/user_model.dart';
import 'package:urnavotos/repositories/recover_pass_repository.dart';
import 'package:urnavotos/services/prefs_service.dart';

class RecoverViewModel{

  void doCpf(cpf){
    UserModel userModel = UserModel(
      userCpf: cpf,
    );
    print(userModel);
    _saveCpf(userModel);

  }
  void _saveCpf(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('cpf',
      jsonEncode(userModel.toJson(),
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
  Future<int?> statusRecoverPass() async{
    UserModel savedCpf = await _getSavedCpf();
    int? status;
    await recoverPass(cpf: savedCpf.userCpf).then((value){
      status = value;
    });
   return status;
  }
}