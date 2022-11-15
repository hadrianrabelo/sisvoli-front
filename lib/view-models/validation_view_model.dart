class ValidationViewModel{

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