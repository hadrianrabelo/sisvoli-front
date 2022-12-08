import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:urnavotos/values/background.dart';
import '../view-models/adress_page_model.dart';
import 'package:http/http.dart' as http;

class AdressPage extends StatefulWidget {
  const AdressPage({Key? key}) : super(key: key);

  @override
  State<AdressPage> createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  final _formKey = GlobalKey<FormState>();
  late Future<Map<String,dynamic>> estados;
  late Future<List<String>> estado;
  final Map<String, dynamic> _userAddress = {};
  late final TextEditingController _cepController = TextEditingController(text: _userAddress['zipCode']);
  late final TextEditingController _numberController = TextEditingController(text: _userAddress['number']);
  late final TextEditingController _streetController = TextEditingController(text: _userAddress['street']);
  late final TextEditingController _districtController = TextEditingController(text: _userAddress['district']);
  late final TextEditingController _complementController = TextEditingController(text: _userAddress['complement']);
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  String? selectedState;
  String? selectedCity;
  bool isLoading = true;
  late int statusCode;
  List stateAll = [];
  late List listCities = [];
  String? _myCity;
  String? _myCityName;
  final _myStateId = {};
  String? _myState;

  @override
  void initState() {
   // getAddress();
    getAddress().then((value) {
      setState(() {
        statusCode = value;
      });
    });
    getStateList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Endereço',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontFamily: 'Inter',
            ),
          ),
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
        ),
        body: SafeArea(
          child: BackGround(
            background: Form(
              key: _formKey,
              child: isLoading
                ? Center(child: CircularProgressIndicator(),)
                : /*FutureBuilder<List<String>?>(
                  future: getAddress(),
                  builder:(context, snapshot){
                    var data = snapshot.data!;
                    return Stack(
                      children: [*/
                        ListView(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(24.0),
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      color: Color.fromRGBO(255, 255, 255, 0.07),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "País",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          decoration: const  InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintText: "Brazil",
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                          enableInteractiveSelection: false,
                                          focusNode: AlwaysDisabledFocusNode(),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "CEP",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _cepController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Número",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _numberController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Rua",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _streetController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Bairro",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _districtController ,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Complemento",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        TextFormField(
                                          controller: _complementController,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'Inter',
                                          ),
                                          decoration: const InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.white54,
                                              ),
                                            ),
                                            hintStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17,
                                              fontFamily: 'Inter',
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Estado",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: DropdownButtonFormField<String>(
                                              dropdownColor: Colors.black87,
                                              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54))),
                                              isExpanded: true,
                                              hint: const Text("Selecione o Estado", style: TextStyle(color: Colors.white54),),
                                              value: _myState,// ?? data[0],
                                              /*items: data.map((String items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child: Text(items),
                                                );
                                              }).toList(),*/
                                              items: stateAll.map((item){
                                                return DropdownMenuItem(
                                                  value: item['id'].toString(),
                                                  child: Text(item['name'], style: TextStyle(color: Colors.white54),),
                                                );
                                              }).toList(),
                                              onChanged: (value) => setState(() {
                                                _myCity = null;
                                                _myState = value;
                                                _getCitiesList(state: _myState);
                                                print("estado: $value");
                                                /*_getCitiesList(state: value).then((newValue){
                                                  _myState = newValue;
                                                  setState(() {
                                                  });
                                                });*/
                                                print(_myState);
                                              },),

                                              /*onTap: (){
                                                _getCitiesList(state: _myState);
                                              },*/
                                          ),
                                        ),
                                        const SizedBox(height: 12,),
                                        const Text(
                                          "Cidade",
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 13,
                                            fontFamily: 'Inter',
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width,
                                          child: DropdownButtonFormField<String>(
                                              dropdownColor: Colors.black87,
                                              decoration: InputDecoration(enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54))),
                                              isExpanded: true,
                                              value: _myCity,
                                              hint: const Text("Selecione a Cidade", style: TextStyle(color: Colors.white54),),
                                              items: listCities.map((item){
                                                return DropdownMenuItem(
                                                  value: item['id'].toString(),
                                                  child: Text(item['name'], style: TextStyle(color: Colors.white54),),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                _myCity = value;
                                                //_getCitiesList();
                                                print(_myCity);
                                              },

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Divider(color: Colors.white38, thickness: 2,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      /*],
                    );
                  }
              )*/
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
                  width: MediaQuery.of(context).size.width * 0.87,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      print(statusCode);
                      if(statusCode == 200){
                        editAddress(
                          zipCode: _cepController.text,
                          number: _numberController.text,
                          street: _streetController.text,
                          district: _districtController.text,
                          complement: _complementController.text,
                          cityId: _myCity,
                        ).then((value){
                          setState(() {
                            if(value == 200){
                              print("Deu Certo");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.redAccent,
                                    content: Text('Informações salvas com sucesso!'),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                            }else{
                              print("Deu Errado");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.redAccent,
                                    content: Text('Houve um erro, verifique suas informações!'),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                            }
                          });
                        });
                      }else if(statusCode == 404){
                        //_formKey.currentState?.validate();
                        registerAddress(
                          zipCode: _cepController.text,
                          number: _numberController.text,
                          street: _streetController.text,
                          district: _districtController.text,
                          complement: _complementController.text,
                          cityId: _myCity,
                        ).then((value){
                          setState(() {
                            if(value == 200){
                              print("Deu Certo");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.redAccent,
                                    content: Text('Informações salvas com sucesso!'),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                            }else{
                              print("Deu Errado");
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.redAccent,
                                    content: Text('Houve um erro, verifique suas informações!'),
                                    behavior: SnackBarBehavior.floating,
                                  )
                              );
                            }
                          });
                        });
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(backgroundColor: Colors.redAccent,
                              content: Text('Houve um erro, porfavor tente novamente mais tarde!'),
                              behavior: SnackBarBehavior.floating,
                            )
                        );
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          Color.fromRGBO(38, 110, 215, 1.0)),
                    ),
                    child: const Text(
                      "Salvar Localização",
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
  }
  var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMzY1Nzc5fQ.W6uzaTmwm5OpjbI_28ta3GGSZGKCPN5BZEl2wZ8VEFQ';
  Future<int> getAddress() async{
    var url = Uri.parse("http://10.0.0.136:8080/address/");
    //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMjc0OTkwfQ.9NKf88Ypds7cWD5m_QckFXG_wsv2Fo5ithIGGH_SQAY';
    var response = await http.get(
        url,
        headers: {
          HttpHeaders.contentTypeHeader:'application/json',
          HttpHeaders.authorizationHeader: "Bearer $token",
        },
    );
    if(response.statusCode == 200){
      Map<String, dynamic> listAddress = jsonDecode(response.body);
      print(listAddress);
     /* List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["ClassName"]);
      }
      setState(() {
        isLoading = false;
      });
      return items;*/
      setState(() {
        isLoading = false;
        _userAddress.addAll(listAddress);
        _myCity = listAddress['cityId'].toString();
        print("id:$_myCity");
        //getCityById
        _getCityById(id: _myCity);

      });
      //return response.statusCode;
    }else if(response.statusCode == 404){

      setState(() {
        isLoading = false;
        _userAddress.addAll({});
      });
    }
    return response.statusCode;
  }
  Future editAddress({zipCode,number,street,district,complement,cityId}) async{
    //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMjc0OTkwfQ.9NKf88Ypds7cWD5m_QckFXG_wsv2Fo5ithIGGH_SQAY';
    var url = Uri.parse('http://10.0.0.136:8080/address/');
    Map<String, String> bodyContent = {
      "zipCode": zipCode,
      "number": number,
      "street":street,
      "district": district,
      "complement": complement,
      "cityId": cityId
    };
    if(bodyContent["zipCode"]!.isEmpty){
      print("zipCode: ${bodyContent["zipCode"]}");
      bodyContent.remove("zipCode");
    }
    if(bodyContent["number"]!.isEmpty){
      print("number: ${bodyContent["number"]}");
      bodyContent.remove("number");
    }
    if(bodyContent["street"]!.isEmpty){
      print("street: ${bodyContent["street"]}");
      bodyContent.remove("street");
    }
    if(bodyContent["district"]!.isEmpty){
      print("district: ${bodyContent["district"]}");
      bodyContent.remove("district");
    }
    if(bodyContent["complement"]!.isEmpty){
      print("complement: ${bodyContent["complement"]}");
      bodyContent.remove("complement");
    }
    if(bodyContent["cityId"]!.isEmpty){
      print("cityId: ${bodyContent["cityId"]}");
      bodyContent.remove("cityId");
    }
    var response = http.put(url,headers:{
      HttpHeaders.contentTypeHeader:'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    } ,body:jsonEncode(bodyContent));
  }
  Future registerAddress({zipCode,number,street,district,complement,cityId}) async{
    var url = Uri.parse('http://10.0.0.136:8080/address/');
    //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMjc0OTkwfQ.9NKf88Ypds7cWD5m_QckFXG_wsv2Fo5ithIGGH_SQAY';
    Map<String, String> bodyContent = {
      "zipCode": zipCode, // cep
      "number": number, // numero da casa
      "street":street, //id cidade, puxa o estado junto
      "district": district, //vai ter rua e numero da casa separado
      "complement": complement, // complemento
      "cityId": cityId // bairro
    };
    var response = http.post(url,
        headers: {
      HttpHeaders.contentTypeHeader:'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    },
        body: jsonEncode(bodyContent)
    );
  }
  Future getStateList() async{
    //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMjc0OTkwfQ.9NKf88Ypds7cWD5m_QckFXG_wsv2Fo5ithIGGH_SQAY';
    var url = Uri.parse('http://10.0.0.136:8080/state/all');
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader:'application/json; charset=utf-8',
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    List stateList = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    setState(() {
      stateAll.addAll(stateList);
    });
  }
  Future _getCityById({id}) async{
    var url = Uri.parse('http://10.0.0.136:8080/city/$id');
    var response = await http.get(url,headers: {
      HttpHeaders.contentTypeHeader:'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    Map<String, dynamic> stateId = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    print(stateId['stateId']);
    setState(() {
      _myStateId.addAll(stateId);
      print(_myStateId);
      _myState = _myStateId['stateId'].toString();
    });
    _getCitiesList(state: _myState);
    //print(jsonDecode(const Utf8Decoder().convert(response.bodyBytes))['stateId']);
  }
  Future _getCitiesList({state}) async{
    //var token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiI5MTc2OTQwNzA1NyIsInJvbGUiOiJERUZBVUxUIiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo4MDgwL2xvZ2luIiwiZXhwIjoxNjcwMjc0OTkwfQ.9NKf88Ypds7cWD5m_QckFXG_wsv2Fo5ithIGGH_SQAY';
    var url = Uri.parse('http://10.0.0.136:8080/state/$state/cities');
    var response = await http.get(url, headers: {
      HttpHeaders.contentTypeHeader:'application/json',
      HttpHeaders.authorizationHeader: "Bearer $token",
    });
    List cityList = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    setState(() {
      listCities = cityList;
      //listCities.addAll(cityList);
    });
  }

}
