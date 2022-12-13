import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urnavotos/values/background.dart';
import 'package:urnavotos/values/custom_colors.dart';
import '../repositories/login_repository.dart';
import 'package:http/http.dart' as http;

class MenuView extends StatefulWidget {
  const MenuView({Key? key}) : super(key: key);

  @override
  State<MenuView> createState() => _MenuViewState();
}

class _MenuViewState extends State<MenuView> {
  String _listApi = dotenv.get("API_HOST", fallback: "");
  late Map<String, dynamic> userName = {};
  final urlImage = 'assets/images/sisvoli.png';
  @override
    void initState() {
      getData();
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.9,
        color: Colors.black87,
        child: Column(
          children: [
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) => Container(
    //color: Colors.white10,
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top
    ),
    child: Column(
      children: [
        CircleAvatar(radius: 52,
        backgroundColor: Colors.black26,
        backgroundImage: AssetImage(urlImage),
        ),
        //Icon(Icons.account_circle, color: Colors.white,size: 100,),
        const SizedBox(height: 12 ,),
        Text('Olá, ${userName['name']}', style: const TextStyle(color: Colors.white, fontSize: 25),),
        const SizedBox(height: 12,),
      ],
    ),
  );

  Widget buildMenuItems(BuildContext context) => Container(
    //color: Colors.white10,
    padding: const EdgeInsets.all(17),
    child: Wrap(
      runSpacing: 0,
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined, color: Colors.white54,),
          title: const Text("Home", style: TextStyle(color: Colors.white),),
          onTap: () => Navigator.of(context).pushReplacementNamed('/bottom_bar'),
        ),
        const Divider(color: Colors.white54,
          thickness: 0.9,
        ),
        ListTile(
          leading: const Icon(Icons.person_add_alt_outlined, color: Colors.white54,),
          title: const Text("Perfil", style: TextStyle(color: Colors.white),),
          onTap: (){
            Navigator.pop(context);

            Navigator.pushNamed(context, '/edit_profile');
            },
        ),
        const Divider(color: Colors.white54,
          thickness: 0.8,
        ),
        ListTile(
          leading: const Icon(Icons.add_business_outlined, color: Colors.white54,),
          title: const Text("Endereço", style: TextStyle(color: Colors.white),),
          onTap: (){
            Navigator.pop(context);

            Navigator.pushNamed(context, '/address');
          },
        ),
        const Divider(color: Colors.white54,
          thickness: 0.8,
        ),
        ListTile(
          leading: const Icon(Icons.logout_outlined, color: Colors.white54,),
          title: const Text("Sair", style: TextStyle(color: Colors.white),),
          onTap: () async {
            Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.clear(); 
          },
        ),
      ],
    ),
  );
  Future getData() async{
    var token = {};
    await accessToken().then((value) {
      setState(() {
        token = value;
      });
    });
    var url = Uri.parse("$_listApi/user/user-data/");
    var response = await http.get(
      url,
      headers: {
        HttpHeaders.contentTypeHeader:'application/json',
        HttpHeaders.authorizationHeader: "Bearer ${token['access_token']}",
      },
    );
    if(response.statusCode == 200){
      setState(() {
        userName.addAll(jsonDecode(response.body));
      });
    }
  }
}
