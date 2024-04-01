import 'package:cleaning_tracker/splash.dart';
import 'package:flutter/material.dart';
import 'pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //A linha abaixo permite que a main seja assincrona e que inicie normamente no Android
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final ThemeData dialogTheme = ThemeData(
    dialogBackgroundColor: Color.fromARGB(255, 255, 255, 255),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 107, 125, 142),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(
          Color.fromARGB(255, 107, 125, 142),
        ),
      ),
    ),
    listTileTheme: ListTileThemeData(
      selectedColor: Color.fromARGB(255, 183, 211, 237),
    ),
    fontFamily: 'Quicksand',
  );
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cleaning Tracker',
      home: SplashScreen(),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: dialogTheme, child: child!);
      },
    );
  }
}
