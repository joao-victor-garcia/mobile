import 'package:cleaning_tracker/pages/home/home.dart';
import 'package:cleaning_tracker/pages/auth/forgotpassworddialog.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _signInWithEmailAndPassword(BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: _emailController.text, password: _passwordController.text);

      //Autenticação bem sucedida, navegar para a proóxima tela
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } catch (e) {
      //Autenticação falhou, exibir mensagem de erro
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erro de autenticação'),
              content: Text('Erro ao fazer login: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background_login.png'),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 350,
              height: 350,
            ),
            SizedBox(
              height: 150,
            ),
            Container(
                width: 350,
                child: TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                      labelText: 'E-mail',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.75),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.blue))),
                  cursorColor: Colors.blue,
                )),
            SizedBox(
              height: 20,
            ),
            Container(
                width: 350,
                child: TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.75),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.blue))),
                  cursorColor: Colors.blue,
                  obscureText: true,
                )),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => _signInWithEmailAndPassword(context)
                //lógica para processar o login

                ,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 183, 211, 237),
                    padding:
                        EdgeInsets.symmetric(vertical: 25, horizontal: 100),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30))),
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )),
            SizedBox(
              height: 60,
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return ForgetPasswordDialog();
                  },
                );
              },
              child: Text('forgot your password?',
                  style: TextStyle(color: Colors.white, fontSize: 15)),
            )
          ],
        )),
      ),
    );
  }
}
