import 'package:shared_preferences/shared_preferences.dart';

class PrefsService{
 void saveUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();


  }
}