import 'package:shared_preferences/shared_preferences.dart';
Future<bool>authUser() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('access_token');
  if (accessToken == null) {
    return false;
  } else {
    return true;
  }
}