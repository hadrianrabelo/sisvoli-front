import 'package:flutter/material.dart';

class CustomColors{
  final Color _primaryButton = const Color.fromRGBO(38, 110, 215, 1.0);
  final Color _primaryTextField = const Color.fromRGBO(255, 255, 255, 0.07);
  final Color _confirmButton = const Color.fromRGBO(38, 110, 215, 1.0);

  Color get getPrimaryButton{
    return _primaryButton;
  }

  Color get getPrimaryTextField{
    return _primaryTextField;
  }

  Color get getConfirmButton{
    return _confirmButton;
  }

}

