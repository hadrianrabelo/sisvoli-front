import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:urnavotos/repositories/creating_poll_repository.dart';
import 'package:urnavotos/values/background.dart';
import 'package:intl/intl.dart';
import 'package:urnavotos/view-models/editing_poll_page_model.dart';
import 'package:http/http.dart' as http;
import '../repositories/login_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PollPageUser extends StatefulWidget {
  const PollPageUser({Key? key}) : super(key: key);

  @override
  State<PollPageUser> createState() => _PullPageUserState();
}

class _PullPageUserState extends State<PollPageUser> {
  final _formKey = GlobalKey<FormState>();
  String _listApi = dotenv.get("API_HOST", fallback: "");
  Map<String, dynamic> resultList= {};
  bool isLoading = true;
  late List<GDPData> _chartData;

  @override
  void initState() {
    getPollResult(idPoll: "1546cadf-c143-4590-a74a-eab8cf02b8da");
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              icon: const Icon(Icons.arrow_back_ios_new_outlined,
                  color: Colors.white),
            ),
            backgroundColor: Colors.black,
            title: const Text(
              'Relatório',
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontFamily: 'Inter',
              ),
            ),
          ),
          body: BackGround(
            background: Form(
              key: _formKey,
              child: isLoading //_controller.isValid
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Center(
                          child: CircularProgressIndicator(),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Carregando...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8.0)),
                              color: Color.fromRGBO(255, 255, 255, 0.07),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 9,
                                ),
                                const Text(
                                  ' Quantidade de votos:',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const Text(
                                  " Total: ",
                                  style: TextStyle(
                                    color: Color.fromRGBO(38, 110, 215, 100),
                                    fontSize: 17,
                                    fontFamily: "Inter",
                                  ),
                                ),
                                /*TextFormField(
                                  enableInteractiveSelection: false,
                                  focusNode: AlwaysDisabledFocusNode(),
                                  initialValue:
                                      _controller.description ?? "null",
                                  style: const TextStyle(
                                    color: Color.fromRGBO(141, 141, 141, 100),
                                    fontSize: 17,
                                  ),
                                  decoration: const InputDecoration(
                                    fillColor:
                                        Color.fromRGBO(255, 255, 255, 0.07),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(20),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.white70,
                                    )),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      style: BorderStyle.none,
                                    )),
                                  ),
                                  maxLines: 6,
                                  minLines: 6,
                                ),*/
                                SfCircularChart(
                                  legend: Legend(isVisible: true, overflowMode: LegendItemOverflowMode.wrap),
                                  series: <CircularSeries>[
                                    PieSeries<GDPData, String>(
                                      dataSource: _chartData,
                                      xValueMapper: (GDPData data,_) => data.continent,
                                      yValueMapper: (GDPData data,_) => data.gdp,
                                      dataLabelSettings: const DataLabelSettings(isVisible: true)
                                    )
                                  ],
                                ),
                                /*const SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text(
                                      "OPÇÃO VENCEDORA",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontFamily: "Inter",
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Column(children: [
                                  TextFormField(
                                    enableInteractiveSelection: false,
                                    focusNode: AlwaysDisabledFocusNode(),
                                    initialValue: "",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(141, 141, 141, 100),
                                      fontSize: 17,
                                    ),
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.0)),
                                      ),
                                      disabledBorder: OutlineInputBorder(),
                                      fillColor:
                                          Color.fromRGBO(100, 29, 139, 30),
                                      filled: true,
                                    ),
                                  ),
                                ]),*/
                               /* const SizedBox(
                                  height: 24,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                const SizedBox(
                                  height: 20,
                                )*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: const Color.fromARGB(255, 1, 1, 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 48,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.87,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                    child: ElevatedButton(
                      onPressed: () {

                      },
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                            Color.fromRGBO(38, 110, 215, 1.0)),
                      ),
                      child: const Text(
                        "Retornar",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Roboto',
                            color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
  Future getPollResult({idPoll}) async{
 /*   var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });*/
    var url = Uri.parse("$_listApi/poll/indicators/$idPoll");
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:'application/json',
        //HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
        HttpHeaders.authorizationHeader: "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIzOTU0Mzc4MDAwNSIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovLzI2LjEzMi4xMjAuNjI6ODA4MC9sb2dpbiIsImV4cCI6MTY3MDgxMzEwNH0.xGZWeOOb5FoZDmXUPuohLWz-Sjp1DSsuxwxWdoX0nrI",
      },
    );
    isLoading = false;
    if(response.statusCode == 200){
      Map<String, dynamic> mapResult = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      /*Map<String, dynamic> mapResult = {
        "pollId": "aef5c7b4-29e8-44bc-8723-dd68b2625339",
        "voteCount": 123,
        "optionRanking": [
          {
            "id": "0fa5318e-7173-4862-ba34-4c5c9f3ecd3d",
            "name": "sim",
            "totalVotes": 100
          },
          {
            "id": "8adede50-748b-47da-88d2-627ed45e6152",
            "name": "não",
            "totalVotes": 23
          }
        ]
      }*/;
      print(mapResult);
      setState(() {
        isLoading = false;
        resultList = mapResult;
      });
    }else{
      print(response.body);
    }
  }
  List<GDPData> getChartData(){
    final List<GDPData> chartData = [
      GDPData(resultList['optionRanking'][0]['name'], resultList['optionRanking'][0]['totalVotes']),
      GDPData(resultList['optionRanking'][1]['name'], resultList['optionRanking'][1]['totalVotes']),
    ];
    return chartData;
  }
}

class GDPData{
  GDPData(this.continent, this.gdp);
  final String continent;
  final int gdp;
}