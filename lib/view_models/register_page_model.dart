import 'package:flutter/material.dart';

class RegisterPageModel {

  String? validMailReturn(mail) {
    if (mail == null || mail.isEmpty) {
      return "E-mail obrigatório";
    } else if (!RegExp(
            r"^[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])+")
        .hasMatch(mail)) {
      return "Digite um e-mail válido";
    }
      return null;
    }

  bool selectedIcon(value) {
    if (value == null || value.isEmpty) {
      return true;
    }
      return false;
    }

  String? validDate(value) {
    if (value == null || value.isEmpty) {
      return "Seleção de data obrigatória";
    }
    return null;
  }

  String? validPassword(pass, {secondPass}) {
    if (pass == null || pass.isEmpty) {
      return "Senha obrigatória.";
    } else if (pass.length < 9) {
      return "A senha deve conter no mínimo 8 caracteres.";
    } else if (pass != secondPass) {
      return "As senhas devem ser iguais";
    }
      return null;
  }

  String? validName(String? name) {
    if(name == null || name.isEmpty) {
      return "Nome obrigatório";
    } else if (name.length < 10) {
      return "O nome está imcompleto";
    }
    return null;
  }

  String? validUser(String? name) {
    if(name == null || name.isEmpty) {
      return "Nome de usuário obrigatório";
    } else if (name.length < 10) {
      return "O nome de usuário deve conter no minimo 10 caracteres";
    }
    return null;
  }

  SnackBar snackBarGender = const SnackBar(
    content: Text("Seleção de gênero obrigatória"),
    backgroundColor: Colors.red,
  );

  SnackBar snackBarSucess = const SnackBar(
    content: Text("Cadastro feito com sucesso"),
    backgroundColor: Colors.green,
  );

  SnackBar snackBarDeny = const SnackBar(
    content: Text("Reveja os campos anteriores"),
    backgroundColor: Colors.red,
  );

  SnackBar snackBarNotWaited = const SnackBar(
    content: Text("Erro Inesperado, refaça o processo"),
    backgroundColor: Colors.red,
  );

}












class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}