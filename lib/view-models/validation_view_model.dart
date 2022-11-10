import 'package:urnavotos/models/login_models.dart';

class ValidationViewModel{
  //var loginModel = LoginModel();

  bool valiCpf(String? getCpf) {
    if (getCpf!.isEmpty || (getCpf.length == 11)) {
      return false;
    } else {
      return true;
    }
  }
  bool valiPassword(String? getPass){
    if(getPass!.isEmpty){
      return true;
    }else{
      return false;
    }
  }

  }