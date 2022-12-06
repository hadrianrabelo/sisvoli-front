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

class PollView extends StatefulWidget {
  const PollView({Key? key}) : super(key: key);

  @override
  State<PollView> createState() => _PollViewState();
}


class _PollViewState extends State<PollView> {
  late Future<List<SurveyModel>> polls;
  final List _posts = [];
  int currentTab = 0;
  late final ScrollController _scrollController;
  final loading = ValueNotifier(true);
  bool hasMore = true;
  int pageNumber = 0;
  bool isLoading = false;
  bool isLastPage = false;

  infiniteScrolling(){
    if(_scrollController.offset == _scrollController.position.maxScrollExtent){
      if(isLastPage == false){
        pageNumber++;
        loadPoll();
      }
    }
  }
  @override

  void initState() {
    super.initState();
        _scrollController = ScrollController();
        _scrollController.addListener(infiniteScrolling);
    //authUser().then((onUser) {
      //if (!onUser) {
        loadPoll();
      //} else {
        //surveys = surveyList();
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
    _scrollController.removeListener(infiniteScrolling);
    _scrollController.dispose();
    super.dispose();
  }

  loadPoll(){

    pollList();
    //polls = pollList();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:const MenuView(),
      body: BackGround(
        background: NestedScrollView(
          headerSliverBuilder:(context, isScrolled) => [
            SliverAppBar.medium(
              pinned: true,
              expandedHeight: MediaQuery.of(context).size.height * 0.15,
              title: const Text("A Votar", style: TextStyle(fontFamily: "Inter", color: Colors.white),),
              backgroundColor: const Color.fromARGB(255, 1, 1, 1),
            ),
          ],
            body: //FutureBuilder<List<SurveyModel>>(
            //future: polls,
            //builder: (context, snapshot){
              //if(snapshot.hasData){
                //return Stack(
                  //children: [
                    ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(20.0),
                      itemCount: _posts.length + 1,
                      itemBuilder: (context, index){
                        //SurveyModel poll = snapshot.data![index];
                        if(index < _posts.length){
                          final post = _posts[index];
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
                                  title: Text(post['title'], style: const TextStyle(color: Colors.white, fontFamily: "Inter"),),
                                  subtitle: Text(post['description'], style: const TextStyle(color: Colors.white, fontFamily: "Inter")),
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
                                     hasMore
                                        ?  SizedBox(
                                              height: MediaQuery.of(context).size.height * 0.12,
                                              width: MediaQuery.of(context).size.height * 0.12,
                                              child: SizedBox(
                                                //height: MediaQuery.of(context).size.height * 0.11,
                                                  height: 20,
                                                  width: 20,
                                                  child: CircularProgressIndicator()
                                                  ),
                                        )
                                        : Container(
                                         height: MediaQuery.of(context).size.height * 0.12,
                                        child: const Text("That's all Folks!", style: TextStyle(color: Colors.white, fontFamily: "Inter"),)),

                                ],
                              );


                        }
                      },
                   // ),
                    //CircularProgressIndicator(),
                 // ],
                ),
              //}else if(snapshot.hasError){
               // return Text(snapshot.error.toString(), style: const TextStyle(color: Colors.white),);
              //}
             // return CircularProgressIndicator();
           // }),
        ),
      ),
    );
  }


  Future<void> pollList() async{
    if(isLoading) return;
    isLoading = true;
    int pageSize = 10;
    //fazer refresh token com tempo, accessToken expira em 10 minutos refreshToken expira 30 minutos
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('access_token');
    var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjY5NTA3NDEwfQ.jM7iyaASmg4CFFUVoD4XwBZqYv6JFrXGxOXwym2ZfII';
    var url = Uri.parse('http://10.0.0.136:8080/poll/list?pageSize=$pageSize&pageNumber=$pageNumber');
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

          List listPoll = jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['content'];
          isLastPage = jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['last'];
        setState(() {
          isLoading = false;
          if(listPoll.length < pageSize){
            hasMore = false;
          }
          _posts.addAll(listPoll ?? []);
        });
          //return listPoll.map((json) => SurveyModel.fromJson(json)).toList();
    }else{
      print("Nada");
      throw Exception('Erro não foi possivel carregar as enquetes.');
    }
  }


  loadingIndicatorWidget(){
    return ValueListenableBuilder(
        valueListenable: loading,
        builder: (context, isMore, _){
          return(hasMore)
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
        }
        );
  }

}