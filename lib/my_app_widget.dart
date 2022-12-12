import 'package:flutter/material.dart';
import 'package:urnavotos/views/adress_page.dart';
import 'package:urnavotos/views/bottom_bar_view.dart';
import 'package:urnavotos/views/creating_page.dart';
import 'package:urnavotos/views/edit_profile_view.dart';
import 'package:urnavotos/views/partial_report_view.dart';
import 'package:urnavotos/views/poll_page_user.dart';
import 'package:urnavotos/views/poll_view.dart';
import 'package:urnavotos/views/user_poll_view.dart';
import '/views/new_pass_view.dart';
import '/views/recover_code_view.dart';
import '/views/recover_pass_view.dart';
import '/views/survey_view.dart';
import '/views/login_view.dart';
import '/views/register_page.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sisvoli',
      debugShowCheckedModeBanner: false,
      home: PartialReportView(pollId: "1546cadf-c143-4590-a74a-eab8cf02b8da"),
     //initialRoute: '/login',
      routes: {
        '/login':(context) => const LoginView(),
        '/survey':(context) => const SurveyView(),
        '/poll':(context) => const PollView(),
        '/recover_pass':(context) => const RecoverPassView(),
        '/recover_code':(context) => const RecoverCodeView(),
        '/new_pass':(context) => const NewPassView(),
        '/register':(context) => const RegisterPage(),
        '/bottom_bar':(context) => const BottomBarView(),
        '/edit_profile':(context) => const EditProfileView(),
        '/address':(context) => const AdressPage(),
        '/create_poll':(context) => const CreatingPage(),
        //'/user_poll':(context) => const UserPollView(),
      },
    );
  }
}
