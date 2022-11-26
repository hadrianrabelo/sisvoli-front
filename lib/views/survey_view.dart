import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/auth/auth_user.dart';
import 'package:urnavotos/models/survey_model.dart';
import 'package:urnavotos/values/background.dart';
import 'package:http/http.dart' as http;
import 'package:urnavotos/views/sidebar_menu_view.dart';
import '../values/custom_colors.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({Key? key}) : super(key: key);

  @override
  State<SurveyView> createState() => _SurveyViewState();
}
  class _SurveyViewState extends State<SurveyView> {
  late Future<List<SurveyModel>> surveys;
  late final ScrollController _scrollController;
  final loading = ValueNotifier(true);
  int currentTab = 0;

  @override
 void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(infiniteScrolling);
    //authUser().then((onUser) {
    //  if (!onUser) {
        loadSurvey();
     // } else {
     //   loadSurvey();
        /*Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginView(),
            ),
                (route) => false
        );*/
     // }
    //});
  }
  @override
  void dispose(){
    super.dispose();
    _scrollController.dispose();
  }

  infiniteScrolling(){
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !loading.value){
      loadSurvey();
    }
  }
  loadSurvey() async{
    loading.value = true;
    surveys = surveyList();
    loading.value = false;
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        drawer:const MenuView(),
        body: BackGround(
          background: NestedScrollView(
            headerSliverBuilder:(context, isScrolled) => [
              SliverAppBar.medium(
                //pinned: true,
                //expandedHeight: MediaQuery.of(context).size.height * 0.15,
                title: const Text("Minhas Enquetes", style: TextStyle(fontFamily: "Inter", color: Colors.white, fontSize: 19),),
                backgroundColor: const Color.fromARGB(255, 1, 1, 1),
              ),
            ],
            body: FutureBuilder<List<SurveyModel>>(
              future: surveys,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Stack(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(20.0),
                              itemCount: snapshot.data!.length + 1,
                              itemBuilder: (context, index){
                                if(index < snapshot.data!.length){
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
                                }else{
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context).size.height * 0.12,
                                          child: const Text("That's all Folks!", style: TextStyle(color: Colors.white, fontFamily: "Inter"),)),

                                    ],
                                  );
                                }
                              },
                      ),

                    ],
                  );
                }else if(snapshot.hasError){
                  return Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white),);
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.height * 0.12,
                      child: SizedBox(
                          height: 1,
                          width: 1,
                              child:CircularProgressIndicator()
                      ),
                    ),
                  ],
                );
              }),
          ),
        ),
      );
    }
    Future<List<SurveyModel>> surveyList() async{
    //fazer refresh token com tempo, accessToken expira em 10 minutos refreshToken expira 30 minutos
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? accessToken = prefs.getString('access_token');
      var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjY5NTA3NDEwfQ.jM7iyaASmg4CFFUVoD4XwBZqYv6JFrXGxOXwym2ZfII';
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
    loadingIndicatorWidget(){
        return ValueListenableBuilder(
            valueListenable: loading,
            builder: (context, bool isLoading, _){
              return(isLoading)
                  ? Positioned(
                      left: (MediaQuery.of(context).size.width / 2)-20,
                      bottom: 24,
                      child: const SizedBox(
                        width: 40,
                        height: 40,
                        child: SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                        ),
                      ),
                    )
                  : Container();
            });

    }

  }