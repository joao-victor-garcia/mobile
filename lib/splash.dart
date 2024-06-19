import 'package:flutter/material.dart';
import 'pages/auth/login.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFB7D3ED),
        body: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2)),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: AnimatedOpacity(
                  duration: Duration(seconds: 16),
                  opacity: 1.0,
                  curve: Curves.bounceIn,
                  child: Image.asset(
                    'assets/logo.png',
                    width: 400,
                    height: 400,
                  ),
                ),
              );
            } else {
              return LoginScreen();
            }
          },
        ));
  }
}
