import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urnavotos/auth/auth_user.dart';
import 'package:urnavotos/models/survey_model.dart';
import 'package:urnavotos/values/background.dart';
import 'package:http/http.dart' as http;
import '../values/custom_colors.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({Key? key}) : super(key: key);

  @override
  State<SurveyView> createState() => _SurveyViewState();
}
  class _SurveyViewState extends State<SurveyView> {
  late Future<List<SurveyModel>> surveys;
  int currentTab = 0;

  @override
 void initState() {
    super.initState();
    authUser().then((onUser) {
      if (!onUser) {
       surveys = surveyList();
      } else {
        surveys = surveyList();
        /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
                (route) => false
        );*/
      }
    });
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: BackGround(
          background: NestedScrollView(
            headerSliverBuilder:(context, isScrolled) => [
              SliverAppBar.medium(
                pinned: true,
                expandedHeight: MediaQuery.of(context).size.height * 0.15,
                title: const Text("Enquetes", style: TextStyle(fontFamily: "Inter", color: Colors.white),),
                backgroundColor: const Color.fromARGB(255, 1, 1, 1),
                leading: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.menu),
                ),
                actions: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.search),),
                ],
              ),
            ], body: FutureBuilder<List<SurveyModel>>(
              future: surveys,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                          padding: const EdgeInsets.all(20.0),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            SurveyModel survey = snapshot.data![index];
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children:[
                                Container(
                                  padding: const EdgeInsets.all(10.0),
                                  decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10),),
                                  color: Color.fromRGBO(255, 255, 255, 0.14),
                                  ),
                                  child:ListTile(
                                    title: Text(survey.title!, style: const TextStyle(color: Colors.white),),
                                    subtitle: Text(survey.description!, style: const TextStyle(color: Colors.white)),
                                    tileColor: Colors.white,
                                    trailing: const Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,),
                                    onTap: (){
                                      //Navigator.pushNamed(context, '/login');
                                      //Navigator.push(context, MaterialPageRoute(builder: (context)=> pagina(index)));
                                      //aqui fica o navigator para cada pagina
                                    },
                            ),
                            ),
                                SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                            ],
                            );
                          },
                  );
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white),);
                }
                return const CircularProgressIndicator();
              }),
          ),
        ),
      );
    }
    Future<List<SurveyModel>> surveyList() async{
      var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjY5MjExNTY0fQ._XSxupjHDaEWfpVXLY6Fi6c-QbdlyIlrtCkOM61UGE4';
      var url = Uri.parse('http://10.0.0.136:8080/poll/list/my');
      var response = await http.get(url,
          headers:{
            HttpHeaders.contentTypeHeader:'application/json',
            HttpHeaders.authorizationHeader: "Bearer $token",
            //HttpHeaders.acceptCharsetHeader: 'UTF-8',
            //'Content-Type': 'application/json',
            //'Accept': 'application/json',
            //'Authorization': 'Bearer $accessToken',
          });
      if(response.statusCode == 200){
        List listSurvey = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        return listSurvey.map((json) => SurveyModel.fromJson(json)).toList();
      }else{
        print("Nada");
        throw Exception('Erro não foi possivel carregar as enquetes.');
      }
    }

  }