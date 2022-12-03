import 'package:flutter/material.dart';

class EditingPollPageModel {

  SnackBar snackBarText (String text) {
    return SnackBar(
      content: Text(text),
      backgroundColor: Colors.red,);
  }

  bool selectedIcon(value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  bool chooseValid (value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  String? validAndLength(String? description) {
    if(description == null || description.isEmpty) {
      return "1";
    } else if (description.length < 8) {
      return "2";
    }
    return null;
  }

}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}