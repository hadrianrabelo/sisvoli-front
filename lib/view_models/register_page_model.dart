class RegisterPageModel{
  RegisterPageModel();

  bool ?validCPF(cpf) {

    if(cpf == null || cpf.isEmpty) {
      return false;
    } else {
      return true;
    }
  }


}
