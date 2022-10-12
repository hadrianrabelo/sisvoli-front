import 'package:flutter/material.dart';
import 'package:urnavotos/src/background.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(

          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                  'S',
                style: TextStyle(
                  fontFamily: 'Vermin-Vibes',
                  fontSize: 50,
                ),
              ),
              const TextField(
                decoration: InputDecoration(border: OutlineInputBorder(), labelText: "CPF"),
                keyboardType: TextInputType.number,),
              const SizedBox(height: 30),
              const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Senha"
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: (){},
                      child: const Text("Esqueceu a senha?", style: TextStyle(decoration:TextDecoration.underline, color: Colors.blue))),
                ],
              ),
              const ElevatedButton(onPressed: null, child: Text('Login')),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("É novo por aqui?"),
                  TextButton(
                      onPressed: (){},
                      child: const Text("Registre-se", style: TextStyle(decoration:TextDecoration.underline, color: Colors.blue))),
                ],
              ),
            ],
          ),
      ),
    );
  }
}
