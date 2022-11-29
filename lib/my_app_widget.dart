import 'package:flutter/material.dart';
import 'package:urnavotos/views/edit_profile_view.dart';
/*import '/views/new_pass_view.dart';
import '/views/recover_code_view.dart';
import '/views/recover_pass_view.dart';
import '/views/survey_view.dart';*/
import '/views/login_view.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisvoli',
      debugShowCheckedModeBanner: false,
      //home: NewPassView(),
     initialRoute: '/edit_profile',
      routes: {
        '/login':(context) => const LoginView(),
        //'/survey':(context) => const SurveyView(),
        //'/recover_pass':(context) => const RecoverPassView(),
        //'/recover_code':(context) => const RecoverCodeView(),
        //'/new_pass':(context) => const NewPassView(),
        //'/register':(context) => LoginView(),
        '/edit_profile':(context) => const EditProfileView(),

      },
    );
  }
}
