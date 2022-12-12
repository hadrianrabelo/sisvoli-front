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

class PartialReportView extends StatefulWidget {
  final String pollId;
  const PartialReportView({Key? key, required this.pollId}) : super(key: key);

  @override
  State<PartialReportView> createState() => _PartialReportViewState();
}

class _PartialReportViewState extends State<PartialReportView> {
  final _formKey = GlobalKey<FormState>();
  final _chooseKey = GlobalKey<FormState>();
  final PollController _controller = PollController();
  String _listApi = dotenv.get("API_HOST", fallback: "");
  Map<String, dynamic>? resultList;
  //Map<String, dynamic> mapResult = {};
  bool isLoading = true;
  late List<GDPData> _chartData;
  String? winner;

  @override
  void initState() {
    getPollResult(idPoll: widget.pollId);
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
                      Text(
                        " Total: ${resultList != null ? ['voteCount'] : 0}",
                        style: const TextStyle(
                          color: Color.fromRGBO(38, 110, 215, 100),
                          fontSize: 17,
                          fontFamily: "Inter",
                        ),
                      ),
                      SfCircularChart(
                        legend: Legend(
                          isVisible: true,
                          overflowMode: LegendItemOverflowMode.scroll,
                          textStyle: const TextStyle(color: Colors.white),
                          position: LegendPosition.bottom,
                        ),
                        series: <CircularSeries>[
                          PieSeries<GDPData, String>(
                            dataSource: _chartData,
                            xValueMapper: (GDPData data,_) => data.name,
                            yValueMapper: (GDPData data,_) => data.totalVotes,
                            dataLabelSettings: DataLabelSettings(isVisible: resultList == null ? false : true),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
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
                          initialValue: "$winner",
                          textAlign: TextAlign.center,
                          //textAlignVertical: TextAlignVertical.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(255, 255, 255, 1),
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
                      ]),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
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
                    .width * 0.7,
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
                    "Editar Enquete",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Roboto',
                        color: Colors.white),
                  ),
                ),
              ),
              Container(
                height: 0,
                width: MediaQuery.of(context).size.width*0.03,
              ),
              Container(
                height: 48,
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.15,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                ),
                child: ElevatedButton(
                  onPressed: () {

                  },
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.red),
                  ),
                  child: Icon(Icons.close),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
  Future getPollResult({idPoll}) async{
    var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var url = Uri.parse("$_listApi/poll/indicators/$idPoll");
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
      },
    );
    //isLoading = false;
    if(response.statusCode == 200){
      Map<String, dynamic> mapResult = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
      setState(() {
        isLoading = false;
        resultList = mapResult;
      });
    }else if(response.statusCode == 403){
      print(response.body);
      setState(() {
        isLoading = false;
        resultList = null;
      });
    }
  }
  List<GDPData> getChartData(){
    final List<GDPData> chartData = [];
    int aux = 0;
    if(resultList != null){
      List<Map<String, dynamic>> result = resultList!['optionRanking'];
      print(result.length);

      for (int i = 0; i <= result.length - 1; i++) {
        setState(() {
          if (result[i]['totalVotes'] > aux) {
            aux = result[i]['totalVotes'];
            winner = result[i]['name'];
          }
          chartData.add(GDPData(result[i]['name'], result[i]['totalVotes']));
        });
      }

    }else{
      setState(() {
        chartData.add(GDPData('Sem Opção', 1));
        chartData.add(GDPData('Sem Opção', 1));
        winner = "Enquete em progresso!";
      });
    }
    return chartData;
  }
}

class GDPData{
  GDPData(this.name, this.totalVotes);
  final String name;
  final int totalVotes;
}
/*
class OptionRanking{
  OptionRanking(this.id, this.name, this.totalVotes);
  final String id;
  final String name;
  final int totalVotes;
}*/
