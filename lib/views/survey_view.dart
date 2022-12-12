import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/auth/auth_user.dart';
import 'package:urnavotos/models/survey_model.dart';
import 'package:urnavotos/values/background.dart';
import 'package:http/http.dart' as http;
import 'package:urnavotos/views/editing_poll_page.dart';
import 'package:urnavotos/views/sidebar_menu_view.dart';
import '../repositories/login_repository.dart';
import '../values/custom_colors.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({Key? key}) : super(key: key);

  @override
  State<SurveyView> createState() => _SurveyViewState();
}
  class _SurveyViewState extends State<SurveyView> {
  late Future<List<SurveyModel>> surveys;
  late final ScrollController _scrollController;
  int currentTab = 0;
  String _listApi = dotenv.get("API_HOST", fallback: "");

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
    if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
      loadSurvey();
    }
  }
  loadSurvey() async{
    surveys = surveyList();
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
                                          //Navigator.pushNamed(context, '/user_poll');
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditingPollPage(pollId: survey.id!)));
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
      var token = {};
      await accessToken().then((value) {
        setState(() {
          token = value;
        });
      });
      print("$token");
      var url = Uri.parse('$_listApi/poll/list/my');
      var response = await http.get(url,
          headers:{
            HttpHeaders.contentTypeHeader:'application/json',
            HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
            //HttpHeaders.acceptCharsetHeader: 'UTF-8',
            //'Content-Type': 'application/json',
            //'Accept': 'application/json',
            //'Authorization': 'Bearer $accessToken',
          });
      if(response.statusCode == 200){
        print("ok");
        List listSurvey = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
        return listSurvey.map((json) => SurveyModel.fromJson(json)).toList();
      }else{
        print("Nada");
        throw Exception('Erro não foi possivel carregar as enquetes.');
      }
    }

  }